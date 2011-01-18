if [ $CONFIGURATION = "Release" ] ; then

	BUILD_VERSION=`agvtool vers -terse`
	MARKT_VERSION=`agvtool mvers -terse1`
	RELEASE_FILENAME=TvTaggr_$MARKT_VERSION
	RELEASE_NAME="TvTaggr $MARKT_VERSION"

	BUILD_DIR=build
	TAGGR_DIR=TvTaggr/
	ART_DIR=artwork

	BACKGROUND=$SRC_DIR/images/dmg/growlDMGBackground.png


	cd dmg

	cp -r $CONFIGURATION_BUILD_DIR/$PRODUCT_NAME.app $TAGGR_DIR
	mkdir $TAGGR_DIR/.background || TRUE
	cp $BACKGROUND $TAGGR_DIR/.background
	./ensureCustomIconsExtracted $ART_DIR
	./make-diskimage.sh $BUILD_DIR/$RELEASE_FILENAME.dmg $TAGGR_DIR $RELEASE_NAME dmg_growl.applescript $ART_DIR
fi