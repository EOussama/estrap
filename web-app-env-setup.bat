@ECHO off
REM Web application environment setup



REM The author's name to show up on the <meta name="author" content=""> tag.
SET author=EOussama

REM The name of the folder that will contain javascript files.
SET scriptFolder=scripts

REM The name of the folder that will contain CSS files.
SET styleFolder=styles

REM The name of the folder that will contain images.
SET imagesFolder=images

REM Setting this to true will include EOmponents in your project.
SET eomponents=true

REM Setting this to true will include bootstrap in your project [if set to true, jQuery will automatically be included], and vice versa.
SET bootstrap=false

REM Setting this to true will include jQuery in your project [including bootsrap will have this set to true regardless], and vice versa.
SET jQuery=false

REM Setting this to true will include the font awesome cdn, and vice versa.
SET fontAwesome=false



IF "%bootstrap%" == "true" (
	SET jQuery=true
)

ECHO ---------------------------------------------------------------------------------------------------------------------
ECHO Parameters (To change these, open up the .bat file with a text editor)
ECHO [Author = %author%] - [EOmponents = %eomponents%] - [Bootstrap = %bootstrap%] - [jQuery = %jQuery%] - [Font Awesome = %fontAwesome%]
ECHO ---------------------------------------------------------------------------------------------------------------------
ECHO.

ECHO Enter your project's name:
SET /p projectName=
ECHO Enter your project's description:
SET /p projectDesc=
ECHO Enter your project's keywords (comma separated):
SET /p projectKeyWords=
SET tab = " "

MKDIR "exports"
MKDIR "exports/%projectName%"
CD "exports/%projectName%"
MKDIR "%scriptFolder%", "%styleFolder%", "%imagesFolder%"

CD "%scriptFolder%"
TYPE NUL > main.js
@ECHO // Main javascript file> main.js
CD ../

CD "%styleFolder%"
TYPE NUL > main.css
@ECHO * {> main.css
@ECHO %tab% %tab% %tab% %tab% margin: 0;>> main.css
@ECHO %tab% %tab% %tab% %tab% padding: 0;>> main.css
@ECHO }>> main.css
CD ../

IF "%eomponents%" == "true" (
	CD ../../resources/EOmponents/styles
	XCOPY eomponents.css ..\..\..\"exports\%projectName%"\"%styleFolder%" /e
	CD ../scripts
	XCOPY eomponents.js ..\..\..\"exports\%projectName%"\"%scriptFolder%" /e
	CD ../../../"exports/%projectName%"
)

IF "%bootstrap%" == "true" (
	CD ../../resources/bootstrap-4.0.0-dist/css
	XCOPY bootstrap.min.css ..\..\..\"exports\%projectName%"\"%styleFolder%" /e
	CD ../js
	XCOPY bootstrap.min.js ..\..\..\"exports\%projectName%"\"%scriptFolder%" /e
	CD ../../../"exports/%projectName%"
)

IF "%jQuery%" == "true" (
	CD ../../resources
	COPY jquery-3.3.1.min.js ..\"exports\%projectName%"\"%scriptFolder%"
	CD ../"exports/%projectName%"
)

TYPE NUL > index.html
@ECHO ^<!DOCTYPE html^>> index.html
@ECHO.>> index.html
@ECHO ^<html lang="en"^>>> index.html
@ECHO %tab% %tab% %tab% %tab% ^<head^>>> index.html
@ECHO %tab% %tab% %tab% %tab% %tab% %tab% %tab% %tab% ^<meta charset="UTF-8"^>>> index.html
@ECHO %tab% %tab% %tab% %tab% %tab% %tab% %tab% %tab% ^<meta name="viewport" content="width=device-width, initial-scale=1.0"^>>> index.html
@ECHO %tab% %tab% %tab% %tab% %tab% %tab% %tab% %tab% ^<meta name="application-name" content="%projectName%"^>>> index.html
@ECHO %tab% %tab% %tab% %tab% %tab% %tab% %tab% %tab% ^<meta name="author" content="%author%"^>>> index.html
@ECHO %tab% %tab% %tab% %tab% %tab% %tab% %tab% %tab% ^<meta name="description" content="%projectDesc%"^>>> index.html
@ECHO %tab% %tab% %tab% %tab% %tab% %tab% %tab% %tab% ^<meta name="keywords" content="%projectKeyWords%"^>>> index.html
@ECHO.>> index.html
IF "%eomponents%" == "true" (
	@ECHO %tab% %tab% %tab% %tab% %tab% %tab% %tab% %tab% ^<link href="%styleFolder%/eomponents.css" rel="stylesheet"^>>> index.html
)
IF "%bootstrap%" == "true" (
	@ECHO %tab% %tab% %tab% %tab% %tab% %tab% %tab% %tab% ^<link href="%styleFolder%/bootstrap.min.css" rel="stylesheet"^>>> index.html
)
IF "%fontAwesome%" == "true" (
	@ECHO %tab% %tab% %tab% %tab% %tab% %tab% %tab% %tab% ^<link href="https://use.fontawesome.com/releases/v5.0.8/css/all.css" rel="stylesheet"^>>> index.html
)
@ECHO %tab% %tab% %tab% %tab% %tab% %tab% %tab% %tab% ^<link rel="stylesheet" type="text/css" href="%styleFolder%/main.css"^>>> index.html
@ECHO %tab% %tab% %tab% %tab% %tab% %tab% %tab% %tab% ^<link rel="icon" type="image/png" href="%imagesFolder%/"^>>> index.html
@ECHO.>> index.html
@ECHO %tab% %tab% %tab% %tab% %tab% %tab% %tab% %tab% ^<title^>%projectName%^</title^>>> index.html
@ECHO %tab% %tab% %tab% %tab% ^</head^>>> index.html
@ECHO.>> index.html
@ECHO %tab% %tab% %tab% %tab% ^<body^>>> index.html
@ECHO. %tab% %tab% %tab% %tab% %tab% %tab% %tab% %tab%>> index.html
IF "%jQuery%" == "true" (
	@ECHO %tab% %tab% %tab% %tab% %tab% %tab% %tab% %tab% ^<script type="text/javascript" src="%scriptFolder%/jquery-3.3.1.min.js"^>^</script^>>> index.html
)
IF "%bootstrap%" == "true" (
	@ECHO %tab% %tab% %tab% %tab% %tab% %tab% %tab% %tab% ^<script type="text/javascript" src="%scriptFolder%/bootstrap.min.js"^>^</script^>>> index.html
)
IF "%eomponents%" == "true" (
	@ECHO %tab% %tab% %tab% %tab% %tab% %tab% %tab% %tab% ^<script type="text/javascript" src="%scriptFolder%/eomponents.js"^>^</script^>>> index.html
)
@ECHO %tab% %tab% %tab% %tab% %tab% %tab% %tab% %tab% ^<script type="text/javascript" src="%scriptFolder%/main.js"^>^</script^>>> index.html
@ECHO %tab% %tab% %tab% %tab% ^</body^>>> index.html
@ECHO ^</html^>>> index.html

ECHO Web application environment created
EXIT