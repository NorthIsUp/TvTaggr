##########################
### Versioning:
###   * Set VERSION and BETA below. BETA should be TRUE or FALSE.
###   * Update the version struct in Core/Source/GrowlApplicationController.m 
###       (needed for proper version checking)
###   * Update the version string in Extras/growlnotify/main.m
#
VERSION=1.1
BETA=FALSE

#
#########################
#
# No changes should be needed below this line
#
#########################
RELEASE_FILENAME=TvTaggr-$(VERSION)
RELEASE_NAME="TvTaggr $(VERSION)"
#RELEASE_SDK_NAME="Growl $(VERSION) SDK"

SRC_DIR=`pwd`/..
BUILD_DIR=build
TAGGR_DIR=$(BUILD_DIR)/Release
#SDK_DIR=$(BUILD_DIR)/SDK
BUILDSTYLE=Deployment
BUILDFLAGS="BUILDCONFIGURATION=$(BUILDSTYLE)"
PRODUCT_DIR=$(shell defaults read com.apple.Xcode PBXProductDirectory 2> /dev/null)
ifeq ($(strip $(PRODUCT_DIR)),)
	TAGGR_BUILD_DIR=$(SRC_DIR)/build/$(BUILDSTYLE)
#	TAGGRNOTIFY_BUILD_DIR=$(SRC_DIR)/Extras/growlnotify/build/$(BUILDSTYLE)
#	TAGGRTUNES_BUILD_DIR=$(SRC_DIR)/Extras/GrowlTunes/build/$(BUILDSTYLE)
#	HARDWARETAGGRER_BUILD_DIR=$(SRC_DIR)/Extras/HardwareGrowler/build/$(BUILDSTYLE)
#	TAGGRMAIL_BUILD_DIR=$(SRC_DIR)/Extras/GrowlMail/build/$(BUILDSTYLE)
#	TAGGRSAFARI_BUILD_DIR=$(SRC_DIR)/Extras/GrowlSafari/build/$(BUILDSTYLE)
else
	TARGET_BUILD_DIR=$(PRODUCT_DIR)/$(BUILDSTYLE)
#	TAGGR_BUILD_DIR=$(TARGET_BUILD_DIR)
#	TAGGRNOTIFY_BUILD_DIR=$(TARGET_BUILD_DIR)
#	TAGGRTUNES_BUILD_DIR=$(TARGET_BUILD_DIR)
#	HARDWARETAGGRER_BUILD_DIR=$(TARGET_BUILD_DIR)
#	TAGGRMAIL_BUILD_DIR=$(TARGET_BUILD_DIR)
#	TAGGRSAFARI_BUILD_DIR=$(TARGET_BUILD_DIR)
endif
PACKAGE_MAKER=/Developer/Applications/Utilities/PackageMaker.app/Contents/MacOS/PackageMaker
ART_DIR=Artwork

#########################

.PHONY: all assertnochanges assertnoconflicts compile clean release source version diskimage

all: assertnochanges version compile release diskimage
all-withlocalchanges: assertnoconflicts version compile release diskimage

assertnochanges:
	if [[ 0 -ne `svn st $(SRC_DIR) | wc -l` ]]; then \
		echo 'You have local changes. Please do not build releases from an unclean checkout. You must revert the changes, commit them, or check out another working copy and build from that.' 1>&2; \
		exit 1; \
	fi
assertnoconflicts:
	if [[ 0 -ne `svn st $(SRC_DIR) | egrep '^C' | wc -l` ]]; then \
		echo 'You have conflicts in your checkout. You will not be able to build until these are resolved. Also, remember that even after you have fixed all conflict marks, you must use "svn resolved"; otherwise, svn will still believe the files are conflicted.' 1>&2; \
		exit 2; \
	fi

version:
#	@# update the CFBundleVersion
#	defaults write $(SRC_DIR)/Core/Resources/GrowlHelperApp-Info CFBundleVersion '$(VERSION)'
#	defaults write $(SRC_DIR)/Framework/Resources/Growl-WithInstaller.framework-Info CFBundleVersion '$(VERSION)'
#	defaults write $(SRC_DIR)/Framework/Resources/Growl.framework-Info CFBundleVersion '$(VERSION)'
#	defaults write $(SRC_DIR)/Core/Resources/Info CFBundleVersion '$(VERSION)'
#	defaults write $(SRC_DIR)/Extras/GrowlCode/Info CFBundleVersion '$(VERSION)'
#	defaults write $(SRC_DIR)/Extras/GrowlMail/Info CFBundleVersion '$(VERSION)'
#	defaults write $(SRC_DIR)/Extras/GrowlSafari/Info CFBundleVersion '$(VERSION)'
#	defaults write $(SRC_DIR)/Extras/GrowlTunes/Info CFBundleVersion '$(VERSION)'
#	defaults write $(SRC_DIR)/Extras/HardwareGrowler/Info CFBundleVersion '$(VERSION)'
#	defaults write $(SRC_DIR)/StatusItem/Resources/MenuExtra-Info CFBundleVersion '$(VERSION)'
#
#	@# update the CFBundleShortVersionString
#	defaults write $(SRC_DIR)/Core/Resources/GrowlHelperApp-Info CFBundleShortVersionString '$(VERSION)'
#	defaults write $(SRC_DIR)/Framework/Resources/Growl-WithInstaller.framework-Info CFBundleShortVersionString '$(VERSION)'
#	defaults write $(SRC_DIR)/Framework/Resources/Growl.framework-Info CFBundleShortVersionString '$(VERSION)'
#	defaults write $(SRC_DIR)/Core/Resources/Info CFBundleShortVersionString '$(VERSION)'
#	defaults write $(SRC_DIR)/Extras/GrowlCode/Info CFBundleShortVersionString '$(VERSION)'
#	defaults write $(SRC_DIR)/Extras/GrowlMail/Info CFBundleShortVersionString '$(VERSION)'
#	defaults write $(SRC_DIR)/Extras/GrowlSafari/Info CFBundleShortVersionString '$(VERSION)'
#	defaults write $(SRC_DIR)/Extras/GrowlTunes/Info CFBundleShortVersionString '$(VERSION)'
#	defaults write $(SRC_DIR)/Extras/HardwareGrowler/Info CFBundleShortVersionString '$(VERSION)'
#	defaults write $(SRC_DIR)/StatusItem/Resources/MenuExtra-Info CFBundleShortVersionString '$(VERSION)'
#
#	@# Convert back to XML plist, since defaults creates binary plists
#	plutil -convert xml1 $(SRC_DIR)/Core/Resources/GrowlHelperApp-Info.plist
#	plutil -convert xml1 $(SRC_DIR)/Framework/Resources/Growl-WithInstaller.framework-Info.plist
#	plutil -convert xml1 $(SRC_DIR)/Framework/Resources/Growl.framework-Info.plist
#	plutil -convert xml1 $(SRC_DIR)/Core/Resources/Info.plist
#	plutil -convert xml1 $(SRC_DIR)/Extras/GrowlCode/Info.plist
#	plutil -convert xml1 $(SRC_DIR)/Extras/GrowlMail/Info.plist
#	plutil -convert xml1 $(SRC_DIR)/Extras/GrowlSafari/Info.plist
#	plutil -convert xml1 $(SRC_DIR)/Extras/GrowlTunes/Info.plist
#	plutil -convert xml1 $(SRC_DIR)/Extras/HardwareGrowler/Info.plist
#	plutil -convert xml1 $(SRC_DIR)/StatusItem/Resources/MenuExtra-Info.plist

compile:
#	$(MAKE) $(BUILDFLAGS) -C $(SRC_DIR)
#	$(MAKE) $(BUILDFLAGS) -C $(SRC_DIR)/Extras/GrowlMail
#	$(MAKE) $(BUILDFLAGS) -C $(SRC_DIR)/Extras/GrowlSafari
#	$(MAKE) $(BUILDFLAGS) -C $(SRC_DIR)/Extras/growlnotify
#	$(MAKE) $(BUILDFLAGS) -C $(SRC_DIR)/Extras/HardwareGrowler
#	$(MAKE) $(BUILDFLAGS) -C $(SRC_DIR)/Extras/GrowlTunes

clean:
	rm -rf $(BUILD_DIR)

realclean: clean
	../build.sh clean

release:
	@# clean build directory
	rm -rf $(BUILD_DIR)
	mkdir $(BUILD_DIR)
	mkdir $(TAGGR_DIR)
	
	@# copy uninstaller
	cp -R "Uninstall Growl.app" $(TAGGR_DIR)
	/Developer/Tools/SetFile -a E $(TAGGR_DIR)/Uninstall\ Growl.app
	
	@# copy webloc files
	cp "Growl Documentation.webloc" "Growl version history.webloc" "Get more styles.webloc" $(TAGGR_DIR)
	
	@# hide extensions of webloc files
	/Developer/Tools/SetFile -a E $(TAGGR_DIR)/*.webloc
	
	@# build the prefpane package
	$(PACKAGE_MAKER) --doc Growl/Growl\ Installer.pmdoc --out $(TAGGR_DIR)/Growl.mpkg --version $(VERSION) -v
	
	@# copy the extras
	mkdir $(TAGGR_DIR)/Extras
	mkdir $(TAGGR_DIR)/Extras/growlnotify
	cp $(TAGGRNOTIFY_BUILD_DIR)/growlnotify $(TAGGR_DIR)/Extras/growlnotify
	cp $(SRC_DIR)/Extras/growlnotify/growlnotify.1 $(TAGGR_DIR)/Extras/growlnotify
	cp $(SRC_DIR)/Extras/growlnotify/install.sh $(TAGGR_DIR)/Extras/growlnotify
	cp $(SRC_DIR)/Extras/growlnotify/*.txt $(TAGGR_DIR)/Extras/growlnotify
	mkdir $(TAGGR_DIR)/Extras/GrowlTunes
	cp -R $(TAGGRTUNES_BUILD_DIR)/GrowlTunes.app $(TAGGR_DIR)/Extras/GrowlTunes
	cp -R $(SRC_DIR)/Extras/GrowlTunes/*.rtfd $(TAGGR_DIR)/Extras/GrowlTunes
	mkdir $(TAGGR_DIR)/Extras/HardwareGrowler
	cp -R $(HARDWARETAGGRER_BUILD_DIR)/HardwareGrowler.app $(TAGGR_DIR)/Extras/HardwareGrowler
	cp $(SRC_DIR)/Extras/HardwareGrowler/*.txt $(TAGGR_DIR)/Extras/HardwareGrowler
	
	@# build GrowlMail package
	mkdir $(TAGGR_DIR)/Extras/GrowlMail
	$(PACKAGE_MAKER) --doc GrowlMail/GrowlMail\ Installer.pmdoc --out $(TAGGR_DIR)/Extras/GrowlMail/GrowlMail.mpkg --version $(VERSION) -v	
	cp $(SRC_DIR)/Extras/GrowlMail/*.rtf $(TAGGR_DIR)/Extras/GrowlMail
	
	@# build GrowlSafari package
	mkdir $(TAGGR_DIR)/Extras/GrowlSafari
	$(PACKAGE_MAKER) --doc GrowlSafari/GrowlSafari\ Installer.pmdoc --out $(TAGGR_DIR)/Extras/GrowlSafari/GrowlSafari.mpkg --version $(VERSION) -v	
	cp -R $(SRC_DIR)/Extras/GrowlSafari/*.rtf $(TAGGR_DIR)/Extras/GrowlSafari
	
	@# build the SDK
	mkdir $(SDK_DIR)
	
	@# copy the webloc files
	cp "Growl Developer Documentation.webloc" "Growl version history for developers.webloc" $(SDK_DIR)
	
	@# hide extensions of webloc files
	/Developer/Tools/SetFile -a E $(SDK_DIR)/*.webloc
	
	@# copy the scripts
	#cp -R $(SRC_DIR)/Scripts $(TAGGR_DIR)
	
	@# copy over relevant files to compile directly into app
	mkdir $(SDK_DIR)/Built-In
	cp $(SRC_DIR)/Framework/Source/GrowlApplicationBridge.h $(SDK_DIR)/Built-In
	cp $(SRC_DIR)/Framework/Source/GrowlApplicationBridge.m $(SDK_DIR)/Built-In
	cp $(SRC_DIR)/Common/Source/GrowlDefines.h $(SDK_DIR)/Built-In
	cp $(SRC_DIR)/Common/Source/GrowlDefinesInternal.h $(SDK_DIR)/Built-In
	cp $(SRC_DIR)/Common/Source/GrowlPathUtilities.h $(SDK_DIR)/Built-In
	cp $(SRC_DIR)/Common/Source/GrowlPathUtilities.m $(SDK_DIR)/Built-In 
	cp $(SRC_DIR)/Common/Source/CFGrowlAdditions.h $(SDK_DIR)/Built-In
	cp $(SRC_DIR)/Common/Source/CFGrowlAdditions.c $(SDK_DIR)/Built-In
	cp $(SRC_DIR)/Common/Source/CFGrowlDefines.h $(SDK_DIR)/Built-In
	cp $(SRC_DIR)/Common/Source/CFURLAdditions.h $(SDK_DIR)/Built-In
	cp $(SRC_DIR)/Common/Source/CFURLAdditions.c $(SDK_DIR)/Built-In
	cp $(SRC_DIR)/Common/Source/CFMutableDictionaryAdditions.h $(SDK_DIR)/Built-In
	cp $(SRC_DIR)/Common/Source/CFMutableDictionaryAdditions.c $(SDK_DIR)/Built-In
	cp $(SRC_DIR)/Core/Source/GrowlPreferencesController.h $(SDK_DIR)/Built-In
	cp $(SRC_DIR)/Core/Source/GrowlTicketController.h $(SDK_DIR)/Built-In
	
	@# copy the frameworks
	mkdir $(SDK_DIR)/Frameworks
	cp -R $(TAGGR_BUILD_DIR)/Growl.framework $(TAGGR_BUILD_DIR)/Growl-WithInstaller.framework $(SDK_DIR)/Frameworks
	
	@# copy the bindings
	cp -R $(SRC_DIR)/Bindings $(SDK_DIR)
	@# remove the AppleScript binding
	rm -rf $(SDK_DIR)/Bindings/applescript
	
	@# remove some symlinks
	rm $(SDK_DIR)/Bindings/tcl/GrowlDefines.h
	rm $(SDK_DIR)/Bindings/tcl/GrowlApplicationBridge.h
	rm $(SDK_DIR)/Bindings/tcl/GrowlApplicationBridge.m
	
	@# delete svn and backup files
	find $(BUILD_DIR) -name ".svn" -type d -exec rm -rf {} \; -prune
	find $(BUILD_DIR) \( -name "*~" -or -name .DS_Store \) -type f -delete
	
	@# optimize nib files, making them uneditable, for releases only
ifeq ($(BETA),FALSE)
	find $(BUILD_DIR) \( -name classes.nib -or -name info.nib \) -type f -delete
endif

diskimage:
	@echo `pwd`
	@# make Growl disk image
	mkdir $(TAGGR_DIR)/.background || TRUE
	cp $(SRC_DIR)/images/dmg/growlDMGBackground.png $(TAGGR_DIR)/.background
	./ensureCustomIconsExtracted $(ART_DIR)
	rm $(BUILD_DIR)/$(RELEASE_FILENAME).dmg || TRUE
	./make-diskimage.sh $(BUILD_DIR)/$(RELEASE_FILENAME).dmg $(TAGGR_DIR) $(RELEASE_NAME) dmg_growl.applescript $(ART_DIR)
	
#	@# make SDK disk image
#	mkdir $(SDK_DIR)/.background || TRUE
#	cp $(SRC_DIR)/images/dmg/growlSDK.png $(SDK_DIR)/.background
#	rm $(BUILD_DIR)/$(RELEASE_FILENAME)-SDK.dmg || TRUE
#	./make-diskimage.sh $(BUILD_DIR)/$(RELEASE_FILENAME)-SDK.dmg $(SDK_DIR) $(RELEASE_SDK_NAME) dmg_sdk.applescript
	
	@echo Build finished
