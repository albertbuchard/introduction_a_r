library(fmri)
library(FIAR)
library(data.table)
library(ggplot2)
library(data.table)

sampleExponential = function (mean = 1, min = null, max = null, jitter = null, pWindow = c(0.001, 0.999)) {
  p = sample(seq(pWindow[1],pWindow[2],0.001),1)
  lambda = 1 / mean

  if (is.null(jitter)) {
    jitter = mean * 0.05
  }

  sample = (-log(1 - p) / lambda)

  if (!is.null(min)) {
    sample = max(sample, min + sample(seq(0,1,0.001),1) * jitter)
  }

  if (!is.null(max)) {
    sample = min(sample, max - sample(seq(0,1,0.001),1) * jitter)
  }

  return(sample)
}

generateDesignMatrix = function (sequence, trialTypes, params = NULL, maintainStimulus = FALSE, countBlackScreenAsPrediction = TRUE) {
  parametersDefault = list(
    observationDuration =  500,
    fixedISIAfterObservation = 2500,
    sampleMeanISIAfterObservation = 3000,
    predictionDuration = 2000,
    fixedISIAfterPrediction = 1000,
    sampleMeanISIAfterPrediction = 3000,
    fixedBlackScreenDuration = 1500,
    sampleMeanBlackScreen = 500,
    maxSampleAfterPrediction = 4000,
    maxSampleAfterObservation =4000,
    maxSampleBlackScreen = 1000)

  if (is.null(params)) {
    params = parametersDefault
  }

  # generate timing for all trials
  timings = NULL
  times = NULL
  predictionTimings = NULL
  predictionTimes = NULL
  BlackScreenPredictionTimes = NULL
  BlackScreenPredictionTimings = NULL
  totalElapsed = 0
  for (i in 1:NROW(sequence)) {
    trialTime = params$observationDuration
    observationISI = params$fixedISIAfterObservation +
      sampleExponential(params$sampleMeanISIAfterObservation, 0, params$maxSampleAfterObservation, params$maxSampleAfterObservation)

    trialDuration = trialTime
    if (maintainStimulus) {
      trialDuration = trialTime + observationISI
     }

    switch(trialTypes[i],
           "observation_prediction" = {
             predictionTimes = c(predictionTimes, totalElapsed + trialTime + observationISI)
             predictionDuration = params$predictionDuration
             predictionISI = params$fixedISIAfterPrediction +
               sampleExponential(params$sampleMeanISIAfterPrediction, 0, params$maxSampleAfterPrediction, params$maxSampleAfterPrediction)

              if (maintainStimulus) {
                predictionDuration = predictionDuration + predictionISI
              }

             trialTime = trialTime + params$predictionDuration + predictionISI
             predictionTimings = c(predictionTimings, predictionDuration)
           },
           "blackout" = {
             if (countBlackScreenAsPrediction) {
               BlackScreenPredictionTimes = c(BlackScreenPredictionTimes, totalElapsed + trialTime + observationISI)
               BlackScreenPredictionTimings = c(BlackScreenPredictionTimings, params$predictionDuration)
             }

             blackISI =
               params$fixedBlackScreenDuration +
               sampleExponential(params$sampleMeanBlackScreen, 0, params$maxSampleBlackScreen, params$maxSampleBlackScreen)



             trialDuration = trialTime
             if (maintainStimulus) {
               trialDuration = trialTime + blackISI
             }

             trialTime = trialTime + blackISI



           })

    timings = c(timings, trialDuration)
    times = c(times, totalElapsed)
    totalElapsed = totalElapsed + trialTime
  }

  #times = shift(cumsum(c(0,timings)), 1, fill = 0) / 1000

  durations = timings / 1000
  times = times / 1000

  predictionDurations = predictionTimings / 1000
  predictionTimes = predictionTimes / 1000
  BlackScreenPredictionTimes = BlackScreenPredictionTimes / 1000
  BlackScreenPredictionTimings = BlackScreenPredictionTimings / 1000
  # generate design matrix
  # times <- c(12, 48, 84, 120, 156, 192, 228, 264)

  tr = 0.250
  scans = ceiling(max(times[NROW(times)],BlackScreenPredictionTimes[NROW(BlackScreenPredictionTimes)]) / tr)

  observationPredictionHrf = fmri.stimulus(scans, onsets = times[trialTypes=="observation_prediction"], durations = durations[trialTypes=="observation_prediction"], TR = tr, times = TRUE)
  blackOutHrf = fmri.stimulus(scans, onsets = times[trialTypes=="blackout"], durations = durations[trialTypes=="blackout"], TR = tr, times = TRUE)
  predictionHrf = fmri.stimulus(scans, onsets = predictionTimes, durations = predictionDurations, TR = tr, times = TRUE)
  blackScreenPredictionHrf = fmri.stimulus(scans, onsets = BlackScreenPredictionTimes, durations = BlackScreenPredictionTimings, TR = tr, times = TRUE)

  # return design matrix
  return(data.frame(observationPredictionHrf= observationPredictionHrf, blackOutHrf = blackOutHrf, predictionHrf = predictionHrf, blackScreenPredictionHrf = blackScreenPredictionHrf))
}

matrixMaxColinearity = function (data) {
  cols = names(data)

  maxR = 0
  for (i in 1:(NROW(cols))) {
    for (j in (i+1):(NROW(cols))) {
      formulaTemp = as.formula(paste(cols[i], " ~ ", cols[j], collapse = ""))
      rTemp = summary(lm(data = data, formula = formulaTemp))$r.squared
      if (rTemp > maxR) {
        maxR = rTemp
      }
    }
  }

  return(maxR)

}

fullSequence = c(
  1,
  3,
  4,
  1,
  3,
  2,
  3,
  4,
  3,
  4,
  1,
  3,
  2,
  4,
  4,
  1,
  4,
  2,
  3,
  4,
  4,
  1,
  1,
  3,
  2,
  1,
  4,
  2,
  1,
  3,
  3,
  2,
  1,
  3,
  2,
  4,
  3,
  1,
  2,
  4,
  3,
  2,
  4,
  3,
  1,
  3,
  4,
  1,
  2,
  4,
  3,
  2,
  3,
  2,
  1,
  2,
  4,
  3,
  2,
  3,
  2,
  4,
  2,
  4,
  3,
  2,
  3,
  2,
  4,
  1,
  4,
  1,
  2,
  4,
  2,
  4,
  1,
  3,
  1,
  2,
  4,
  1,
  4,
  1,
  3,
  2,
  2,
  4,
  1,
  3,
  1,
  2,
  2,
  4,
  4,
  2,
  3,
  2,
  2,
  4,
  4,
  1,
  2,
  3,
  2,
  4,
  4,
  1,
  1,
  4,
  3,
  2,
  4,
  3,
  1,
  3,
  4,
  1,
  2,
  1,
  3,
  1,
  3,
  2,
  1,
  3,
  1,
  3,
  1,
  3,
  2,
  4,
  3,
  2,
  3,
  2,
  3,
  2,
  4,
  1,
  2,
  1,
  2,
  4,
  2,
  4,
  1,
  3,
  1,
  2,
  4,
  3,
  4,
  1,
  3,
  2,
  2,
  4,
  3,
  2,
  1,
  4,
  2,
  1,
  4,
  3,
  2,
  4,
  4,
  1,
  1,
  1,
  3,
  4,
  4,
  1,
  1,
  2,
  1,
  1
)
trialTypes = c("observation_prediction", "blackout", "observation_prediction", "blackout", "observation_prediction", "blackout", "observation_prediction", "blackout", "observation_prediction", "blackout", "observation_prediction", "blackout", "observation_prediction", "blackout", "observation_prediction", "blackout", "observation_prediction", "blackout", "observation_prediction", "blackout", "observation_prediction", "blackout", "observation_prediction", "blackout", "observation_prediction", "blackout", "observation_prediction", "blackout", "observation_prediction", "blackout", "observation_prediction", "blackout", "observation_prediction", "blackout", "observation_prediction", "blackout", "observation_prediction", "blackout", "observation_prediction", "blackout", "observation_prediction", "blackout", "observation_prediction", "blackout", "observation_prediction", "blackout", "observation_prediction", "blackout", "observation_prediction", "blackout", "observation_prediction", "blackout", "observation_prediction", "blackout", "observation_prediction", "blackout", "observation_prediction", "blackout", "observation_prediction", "blackout", "observation_prediction", "blackout", "observation_prediction", "blackout", "observation_prediction", "blackout", "observation_prediction", "blackout", "observation_prediction", "blackout", "observation_prediction", "blackout", "observation_prediction", "blackout", "observation_prediction", "blackout", "observation_prediction", "blackout", "observation_prediction", "blackout", "observation_prediction", "blackout", "observation_prediction", "blackout", "observation_prediction", "blackout", "observation_prediction", "blackout", "observation_prediction", "blackout", "observation_prediction", "blackout", "observation_prediction", "blackout", "observation_prediction", "blackout", "observation_prediction", "blackout", "observation_prediction", "blackout", "observation_prediction", "blackout", "observation_prediction", "blackout", "observation_prediction", "blackout", "observation_prediction", "blackout", "observation_prediction", "blackout", "observation_prediction", "blackout", "observation_prediction", "blackout", "observation_prediction", "blackout", "observation_prediction", "blackout", "observation_prediction", "blackout", "observation_prediction", "blackout", "observation_prediction", "blackout", "observation_prediction", "blackout", "observation_prediction", "blackout", "observation_prediction", "blackout", "observation_prediction", "blackout", "observation_prediction", "blackout", "observation_prediction", "blackout", "observation_prediction", "blackout", "observation_prediction", "blackout", "observation_prediction", "blackout", "observation_prediction", "blackout", "observation_prediction", "blackout", "observation_prediction", "blackout", "observation_prediction", "blackout", "observation_prediction", "blackout", "observation_prediction", "blackout", "observation_prediction", "blackout", "observation_prediction", "blackout", "observation_prediction", "blackout", "observation_prediction", "blackout", "observation_prediction", "blackout", "observation_prediction", "blackout", "observation_prediction", "blackout", "observation_prediction", "blackout", "observation_prediction", "blackout", "observation_prediction", "blackout", "observation_prediction", "blackout", "observation_prediction", "blackout", "observation_prediction", "blackout")


matrices  = generateDesignMatrix(fullSequence, trialTypes)
#matrices$window = (1:NROW(matrices[,1]))
matrices$seconds = (1:NROW(matrices[,1])) * 0.25

#ggplot(matrices, aes(x=window, y=blackOutHrf)) + geom_line()

meltedData = data.table::melt(matrices, id.vars="seconds", value.name = "HRF", variable.name = "condition")

meltedData = data.table(meltedData)
ggplot(meltedData[seconds<100,], aes(x=seconds, y=HRF, color=condition, group=condition)) + geom_line() + theme_bw()
