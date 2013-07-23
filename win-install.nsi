!define PRODUCT_NAME "OCmd"
!define PRODUCT_VERSION "0.2.0"
!define PRODUCT_PUBLISHER "Gemini Wen"
!define PRODUCT_WEB_SITE "http://coffeesherk.github.io/OCmd"
!define PRODUCT_UNINST_KEY "Software\Microsoft\Windows\CurrentVersion\Uninstall\${PRODUCT_NAME}"
!define PRODUCT_UNINST_ROOT_KEY "HKLM"

SetCompressor lzma

; MUI Settings
!define MUI_ABORTWARNING
!define MUI_ICON "OCmd_icon.ico"
!define MUI_UNICON "OCmd_icon.ico"

; Modern UI
!include "MUI.nsh"

; Welcome page
!insertmacro MUI_PAGE_WELCOME
; Directory page
!insertmacro MUI_PAGE_DIRECTORY
; Instfiles page
!insertmacro MUI_PAGE_INSTFILES
; Finish page
!insertmacro MUI_PAGE_FINISH
; Language files
!insertmacro MUI_LANGUAGE "English"


Name "${PRODUCT_NAME} ${PRODUCT_VERSION}"
OutFile "${PRODUCT_NAME}-${PRODUCT_VERSION}.exe"
InstallDir "$PROGRAMFILES\${PRODUCT_NAME}"
ShowInstDetails hide
ShowUnInstDetails hide

Section "MainSection" SEC01

  ; Remove Old Install Files
  RMDir /R $INSTDIR
  delete "$DESKTOP\${PRODUCT_NAME}.lnk"
  delete "$SMPROGRAMS\${PRODUCT_NAME}.lnk"
  DeleteRegKey ${PRODUCT_UNINST_ROOT_KEY} "${PRODUCT_UNINST_KEY}"

  SetOutPath "$INSTDIR"
  SetOverwrite on
  
  File "icudt.dll"
  File "nw.pak"
  File "OCmd.exe"
  
SectionEnd

Section -Post

  ; Uninstaller
  WriteUninstaller "$INSTDIR\uninstall.exe"
  
	; desktop shortcut
	createShortCut "$DESKTOP\${PRODUCT_NAME}.lnk" "$INSTDIR\OCmd.exe"

  ;Registery entries
  WriteRegStr ${PRODUCT_UNINST_ROOT_KEY} "${PRODUCT_UNINST_KEY}" "DisplayName" "$(^Name)"
  WriteRegStr ${PRODUCT_UNINST_ROOT_KEY} "${PRODUCT_UNINST_KEY}" "UninstallString" "$INSTDIR\uninstall.exe"
  WriteRegStr ${PRODUCT_UNINST_ROOT_KEY} "${PRODUCT_UNINST_KEY}" "DisplayIcon" "$INSTDIR\OCmd.exe"
  WriteRegStr ${PRODUCT_UNINST_ROOT_KEY} "${PRODUCT_UNINST_KEY}" "DisplayVersion" "${PRODUCT_VERSION}"
  WriteRegStr ${PRODUCT_UNINST_ROOT_KEY} "${PRODUCT_UNINST_KEY}" "URLInfoAbout" "${PRODUCT_WEB_SITE}"
  WriteRegStr ${PRODUCT_UNINST_ROOT_KEY} "${PRODUCT_UNINST_KEY}" "Publisher" "${PRODUCT_PUBLISHER}"
	
SectionEnd

Section Uninstall

  RMDir /R $INSTDIR
  delete "$DESKTOP\${PRODUCT_NAME}.lnk"
  delete "$SMPROGRAMS\${PRODUCT_NAME}.lnk"
  RMDir /R "$LOCALAPPDATA\Prepros"
  RMDir /R "$APPDATA\Prepros"
  DeleteRegKey ${PRODUCT_UNINST_ROOT_KEY} "${PRODUCT_UNINST_KEY}"
  SetAutoClose true
  
SectionEnd