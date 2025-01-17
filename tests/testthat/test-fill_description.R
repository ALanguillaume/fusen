# Create a new project
tmpdir <- tempdir()
dummypackage <- file.path(tmpdir, "dummypackage")
dir.create(dummypackage)

fill_description(
  pkg = dummypackage,
  fields = list(
    Title = "Build a package from Rmarkdown file",
    Description = "Use Rmarkdown First method to build your package. Start your package with documentation. Everything can be set from a Rmarkdown file in your project.",
    `Authors@R` = c(
      person("Sebastien", "Rochette", email = "sebastien@thinkr.fr", role = c("aut", "cre"), comment = c(ORCID = "0000-0002-1565-9313")),
      person(given = "ThinkR", role = "cph")
    )
  )
)

test_that("fill_description adds DESCRIPTION", {
  expect_true(file.exists(file.path(dummypackage, "DESCRIPTION")))
  lines <- readLines(file.path(dummypackage, "DESCRIPTION"))
  expect_true(lines[1] == "Package: dummypackage")

  # Second launch error and no change
  expect_error(fill_description(
    pkg = dummypackage, fields = list(Title = "Second launch")
  ))
  lines <- readLines(file.path(dummypackage, "DESCRIPTION"))
  expect_true(lines[1] == "Package: dummypackage")

  # Title Case changed
  expect_equal(lines[3], "Title: Build A Package From Rmarkdown File")
})

# Fill description stops if malformed
# _not dot
test_that("no dot description fails", {
  expect_error(
    fill_description(
      pkg = dummypackage,
      fields = list(
        Title = "Build A Package From Rmarkdown file",
        Description = paste("Use Rmd First method to build your package.",
                            "Start your package with documentation.",
                            "Everything can be set from a Rmarkdown file in your project"),
        `Authors@R` = c(
          person("Sebastien", "Rochette", email = "sebastien@thinkr.fr",
                 role = c("aut", "cre"), comment = c(ORCID = "0000-0002-1565-9313")),
          person(given = "ThinkR", role = "cph")
        )
      )
    ),
    "finish with a dot.")
})

# Delete dummy package
unlink(dummypackage, recursive = TRUE)

# Test capwords ----
test_that("capwords works", {
  expect_equal(capwords("using AIC for model selection"), "Using AIC For Model Selection")
})
