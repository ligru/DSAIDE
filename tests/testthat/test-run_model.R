context("test-run_model.R")


test_that("run_model correctly runs different models",
{
            tfinal = 120
            modelsettings =  list(S = 1000, I = 10, R = 0 , n = 0, b = 1e-3, g = 0.5, w = 0, m = 0, tstart = 0, tfinal = tfinal, dt = 0.1, modeltype = "_ode_", plotscale = 'y', nplots = 1)
            modelsettings$simfunction = 'simulate_SIRSd_model_ode'
            result = run_model(modelsettings)
            #check that simulation ran until max time
            Imax = round(max(dplyr::filter(result[[1]]$dat, varnames == "I")$yvals))
            expect_equal(Imax, 163)
            expect_equal(max(result[[1]]$dat$xvals), tfinal)
            expect_is(generate_ggplot(result), "ggplot" )
            expect_is(generate_plotly(result), "plotly" )
            testthat::  expect_is(generate_text(result), "html" )

            modelsettings =  list(S = 1000, I = 10, R = 0 , n = 0, b = 1e-3, g = 0.5, w = 0, m = 0, tstart = 0, tfinal = tfinal, rngseed = 123, modeltype = "_stochastic_", plotscale = 'y', nplots = 1,  nreps = 1)
            modelsettings$simfunction = 'simulate_SIRSd_model_stochastic'
            result = run_model(modelsettings)
            #check that simulation returned specific value of susceptible at end
            Sfinal = min(dplyr::filter(result[[1]]$dat, varnames == "S")$yvals)
            expect_equal(Sfinal, 153)
            expect_is(generate_ggplot(result), "ggplot" )
            expect_is(generate_plotly(result), "plotly" )
            testthat::  expect_is(generate_text(result), "html" )

            tfinal = 120
            modelsettings =  list(S = 1000, I = 10, R = 0 , b = 1e-3, g = 0.5, tstart = 0, tfinal = tfinal, dt = 0.1, modeltype = "_ode_and_discrete_", plotscale = 'y', nplots = 1)
            modelsettings$simfunction =  c('simulate_SIR_model_ode','simulate_SIR_model_discrete')
            modelsettings$modeltypeUI = "_ode_and_discrete_"
            result = run_model(modelsettings)
            #check that simulation ran until max time
            Imaxode = round(max(dplyr::filter(result[[1]]$dat, varnames == "I_ode")$yvals))
            expect_equal(Imaxode, 163)
            Imaxdisc = round(max(dplyr::filter(result[[1]]$dat, varnames == "I_dis")$yvals))
            expect_equal(Imaxdisc, 165)
            expect_equal(max(result[[1]]$dat$xvals), tfinal)
            expect_is(generate_ggplot(result), "ggplot" )
            expect_is(generate_plotly(result), "plotly" )
            testthat::  expect_is(generate_text(result), "html" )

            #for this dt, the simulation produces NaN and an error message as string should be returned
            modelsettings =  list( dt = 3, modeltype = "_discrete_", plotscale = 'y', nplots = 1)
            modelsettings$simfunction = 'simulate_SIR_model_discrete'
            result = run_model(modelsettings)
            expect_is(result, "character")


            tfinal = 120
            modelsettings =  list(S = 1000, I = 10, R = 0 , b = 1e-3, gI = 0.5, w = 0, tstart = 0, tfinal = tfinal, dt = 0.1, modeltype = "_stochastic_", plotscale = 'y', nplots = 1)
            modelsettings$simfunction = 'simulate_SEIRSd_model_stochastic'
            result = run_model(modelsettings)
            #check that simulation ran until max time
            Imax = round(max(dplyr::filter(result[[1]]$dat, varnames == "I")$yvals))
            expect_equal(Imax, 113)
            expect_equal(max(result[[1]]$dat$xvals), tfinal)
            expect_is(generate_ggplot(result), "ggplot" )
            expect_is(generate_plotly(result), "plotly" )
            testthat::  expect_is(generate_text(result), "html" )

            tfinal = 120
            modelsettings =  list(S = 1000, Iu = 1, R = 0 , gIu = 2, rngseed = 123, tstart = 0, tfinal = tfinal, dt = 0.1, modeltype = "_stochastic_", plotscale = 'y', nplots = 1)
            modelsettings$simfunction = 'simulate_Drug_Resistance_Evolution_stochastic'
            result = run_model(modelsettings)
            #check that simulation ran until max time
            Imax = round(max(dplyr::filter(result[[1]]$dat, varnames == "Iu")$yvals))
            expect_equal(Imax, 86)
            expect_equal(max(result[[1]]$dat$xvals), tfinal)
            expect_is(generate_ggplot(result), "ggplot" )
            expect_is(generate_plotly(result), "plotly" )
            testthat::  expect_is(generate_text(result), "html" )


            modelsettings =  list(tnew = 150, tmax = 100)
            modelsettings$modeltype =  "_ode_"
            modelsettings$simfunction = 'simulate_idcontrolmultioutbreak_ode'
            result = run_model(modelsettings)
            expect_is(generate_ggplot(result), "ggplot" )
            expect_is(generate_plotly(result), "plotly" )
            testthat::  expect_is(generate_text(result), "html" )

            modelsettings =  list(tnew = 80, tmax = 100)
            modelsettings$modeltype =  "_ode_"
            modelsettings$simfunction = 'simulate_maternalimmunity_ode'
            result = run_model(modelsettings)
            expect_is(generate_ggplot(result), "ggplot" )
            expect_is(generate_plotly(result), "plotly" )
            testthat::  expect_is(generate_text(result), "html" )

            modelsettings =  list(Sh = 1000, Ih = 10, Rh = 0 , Sv = 1000, Iv = 1, b1 = 0.002, b2 = 0.002, g = 1, w = 0, m = 2, n = 2000, tstart  = 0, tfinal = 100, dt = 0.1, modeltype = "_ode_",  nplots = 1)
            modelsettings$simfunction = 'simulate_Vector_transmission_model_ode'
            result = run_model(modelsettings)
            #check that simulation returned specific value of susceptible at end
            Sfinal = round(min(dplyr::filter(result[[1]]$dat, varnames == "Sh")$yvals))
            expect_equal(Sfinal, 231)
            expect_is(generate_ggplot(result), "ggplot" )
            expect_is(generate_plotly(result), "plotly" )
            testthat::  expect_is(generate_text(result), "html" )


})
