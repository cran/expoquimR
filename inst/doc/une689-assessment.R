## ----setup, include = FALSE---------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment  = "#>"
)
library(expoquimR)

## ----prelim-------------------------------------------------------------------
# Five samples across three working days
data <- data.frame(
  day           = c(1, 1, 2, 3, 3),
  concentration = c(12, 8, 9, 5, 6),   # mg/m³
  time          = c(4,  4, 8, 3, 5)    # hours
)

res_pre <- une689_evaluate_preliminary(data, vla = 10)
res_pre$days_table
res_pre$result

## ----prelim_steps-------------------------------------------------------------
# Daily exposure for day 1 (two samples)
une689_daily_exposure(concentration = c(12, 8), time = c(4, 4))

# Exposure index
une689_exposure_index(ed = 10, vla = 10)

# Classify conformity from a set of IE values
une689_classify_conformity(c(1.0, 0.9, 0.5625))

## ----stat---------------------------------------------------------------------
# Six ED values (3 preliminary + 3 additional)
eds <- c(10, 9, 5.625, 11, 8, 13)

res_est <- une689_evaluate_statistical(eds, vla = 10)

cat("Distribution:", res_est$distribution_type, "\n")
cat("MG =",  round(res_est$MG,  3), "\n")
cat("DSG =", round(res_est$DSG, 3), "\n")
cat("UT =",  res_est$ut, "\n")
cat("LSC(95,70) =", round(res_est$lsc, 3), "\n")
cat("UR =",  round(res_est$ur, 3), "\n")
cat("Result:", res_est$conformity, "\n")

## ----stat_steps---------------------------------------------------------------
# Descriptive statistics
est <- une689_statistics(eds)
est$MG; est$DSG

# Normality and lognormality tests
test <- une689_normality_test(eds)
test$pval_lognormal

# Distribution type (lognormal has priority)
distribution_type <- une689_distribution_type(
  pval_normal    = test$pval_normal,
  pval_lognormal = test$pval_lognormal
)
distribution_type

# Tolerance factor UT for n = 6
une689_ut(6)

# LSC(95,70)
une689_lsc(distribution_type, ut = une689_ut(6), MG = est$MG, DSG = est$DSG)

# Risk index UR
une689_ur(distribution_type, vla = 10, MG = est$MG, DSG = est$DSG)

# Conformity decision
une689_statistical_conformity(ur = une689_ur(distribution_type, vla = 10,
                                               MG = est$MG, DSG = est$DSG),
                                ut = une689_ut(6))

## ----probability_data---------------------------------------------------------
pd <- une689_probability_data(eds)

pd$distribution
pd$data[, c("k", "ed", "pk")]

## ----probability_plot, eval = requireNamespace("ggplot2", quietly = TRUE), fig.alt = "Log-normal probability paper with the six daily exposure values and a fitted straight line."----
une689_probability_plot(eds, vla = 10)

## ----periodic-----------------------------------------------------------------
# Option 1: MG or MA versus the OEL
une689_monitoring_interval_opt1(reference_value = res_est$MG, vla = 10)

# Option 2: LSC(95,70) versus the OEL
une689_monitoring_interval_opt2(lsc = res_est$lsc, vla = 10)

## ----additive-----------------------------------------------------------------
ie_toluene <- 0.20
ie_xylene  <- 0.30
ie_combined <- ie_toluene + ie_xylene

cat("Combined IE:", ie_combined, "\n")
une689_classify_conformity(ie_combined)

## ----excel, eval = FALSE------------------------------------------------------
# ruta <- system.file("plantillas", "plantilla_une689.xlsx", package = "expoquimR")
# res <- une689_from_excel(ruta)
# 
# # Preliminary results and statistical assessment per agent
# res$preliminary$Toluene$result
# res$preliminary$Toluene$statistics$conformity
# 
# # Additive effects table
# res$additive

## ----language-----------------------------------------------------------------
expoquimr_lang("es")
une689_classify_conformity(c(0.02, 0.05))
une689_distribution_type(0.5, 0.5)
une689_monitoring_interval_opt1(0.5, vla = 10)
expoquimr_lang("en")

## ----app, eval = FALSE--------------------------------------------------------
# run_une689()

