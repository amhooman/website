package;


import haxe.io.Bytes;
import lime.utils.AssetBundle;
import lime.utils.AssetLibrary;
import lime.utils.AssetManifest;
import lime.utils.Assets;

#if sys
import sys.FileSystem;
#end

@:access(lime.utils.Assets)


@:keep @:dox(hide) class ManifestResources {


	public static var preloadLibraries:Array<AssetLibrary>;
	public static var preloadLibraryNames:Array<String>;
	public static var rootPath:String;


	public static function init (config:Dynamic):Void {

		preloadLibraries = new Array ();
		preloadLibraryNames = new Array ();

		rootPath = null;

		if (config != null && Reflect.hasField (config, "rootPath")) {

			rootPath = Reflect.field (config, "rootPath");

		}

		if (rootPath == null) {

			#if (ios || tvos || emscripten)
			rootPath = "assets/";
			#elseif android
			rootPath = "";
			#elseif console
			rootPath = lime.system.System.applicationDirectory;
			#else
			rootPath = "./";
			#end

		}

		#if (openfl && !flash && !display)
		openfl.text.Font.registerFont (__ASSET__OPENFL__assets_fonts_pixel_otf);
		openfl.text.Font.registerFont (__ASSET__OPENFL__assets_fonts_vcr_ttf);
		openfl.text.Font.registerFont (__ASSET__OPENFL__flixel_fonts_nokiafc22_ttf);
		openfl.text.Font.registerFont (__ASSET__OPENFL__flixel_fonts_monsterrat_ttf);
		
		#end

		var data, manifest, library, bundle;

		#if kha

		null
		library = AssetLibrary.fromManifest (manifest);
		Assets.registerLibrary ("null", library);

		if (library != null) preloadLibraries.push (library);
		else preloadLibraryNames.push ("null");

		#else

		Assets.libraryPaths["videos"] = rootPath + "manifest/videos.json";
		Assets.libraryPaths["songs"] = rootPath + "manifest/songs.json";
		Assets.libraryPaths["shared"] = rootPath + "manifest/shared.json";
		Assets.libraryPaths["week2"] = rootPath + "manifest/week2.json";
		Assets.libraryPaths["week3"] = rootPath + "manifest/week3.json";
		Assets.libraryPaths["week4"] = rootPath + "manifest/week4.json";
		Assets.libraryPaths["week5"] = rootPath + "manifest/week5.json";
		Assets.libraryPaths["week6"] = rootPath + "manifest/week6.json";
		data = '{"name":null,"assets":"aoy4:pathy33:assets%2Fcharacters%2Fbf-car.jsony4:sizei2528y4:typey4:TEXTy2:idR1y7:preloadtgoR0y39:assets%2Fcharacters%2Fbf-christmas.jsonR2i1748R3R4R5R7R6tgoR0y40:assets%2Fcharacters%2Fbf-pixel-dead.jsonR2i722R3R4R5R8R6tgoR0y44:assets%2Fcharacters%2Fbf-pixel-opponent.jsonR2i1568R3R4R5R9R6tgoR0y35:assets%2Fcharacters%2Fbf-pixel.jsonR2i1564R3R4R5R10R6tgoR0y29:assets%2Fcharacters%2Fbf.jsonR2i2906R3R4R5R11R6tgoR0y30:assets%2Fcharacters%2Fdad.jsonR2i1763R3R4R5R12R6tgoR0y33:assets%2Fcharacters%2Fgf-car.jsonR2i994R3R4R5R13R6tgoR0y39:assets%2Fcharacters%2Fgf-christmas.jsonR2i2138R3R4R5R14R6tgoR0y35:assets%2Fcharacters%2Fgf-pixel.jsonR2i938R3R4R5R15R6tgoR0y29:assets%2Fcharacters%2Fgf.jsonR2i2327R3R4R5R16R6tgoR0y34:assets%2Fcharacters%2Fmom-car.jsonR2i1893R3R4R5R17R6tgoR0y30:assets%2Fcharacters%2Fmom.jsonR2i989R3R4R5R18R6tgoR0y44:assets%2Fcharacters%2Fmonster-christmas.jsonR2i1906R3R4R5R19R6tgoR0y34:assets%2Fcharacters%2Fmonster.jsonR2i1905R3R4R5R20R6tgoR0y44:assets%2Fcharacters%2Fparents-christmas.jsonR2i3428R3R4R5R21R6tgoR0y38:assets%2Fcharacters%2Fpico-player.jsonR2i1636R3R4R5R22R6tgoR0y31:assets%2Fcharacters%2Fpico.jsonR2i1637R3R4R5R23R6tgoR0y39:assets%2Fcharacters%2Fsenpai-angry.jsonR2i1039R3R4R5R24R6tgoR0y33:assets%2Fcharacters%2Fsenpai.jsonR2i1009R3R4R5R25R6tgoR0y33:assets%2Fcharacters%2Fspirit.jsonR2i992R3R4R5R26R6tgoR0y33:assets%2Fcharacters%2Fspooky.jsonR2i1385R3R4R5R27R6tgoR0y43:assets%2Fdata%2Fblammed%2Fblammed-easy.jsonR2i8488R3R4R5R28R6tgoR0y43:assets%2Fdata%2Fblammed%2Fblammed-hard.jsonR2i12097R3R4R5R29R6tgoR0y38:assets%2Fdata%2Fblammed%2Fblammed.jsonR2i9687R3R4R5R30R6tgoR0y37:assets%2Fdata%2Fblammed%2Fevents.jsonR2i5782R3R4R5R31R6tgoR0y44:assets%2Fdata%2Fbopeebo%2Fbopeebo-boobs.jsonR2i4140R3R4R5R32R6tgoR0y43:assets%2Fdata%2Fbopeebo%2Fbopeebo-easy.jsonR2i9178R3R4R5R33R6tgoR0y43:assets%2Fdata%2Fbopeebo%2Fbopeebo-hard.jsonR2i4140R3R4R5R34R6tgoR0y38:assets%2Fdata%2Fbopeebo%2Fbopeebo.jsonR2i9542R3R4R5R35R6tgoR0y37:assets%2Fdata%2Fbopeebo%2Fevents.jsonR2i5047R3R4R5R36R6tgoR0y33:assets%2Fdata%2FcharacterList.txtR2i192R3R4R5R37R6tgoR0y39:assets%2Fdata%2Fcocoa%2Fcocoa-easy.jsonR2i7062R3R4R5R38R6tgoR0y39:assets%2Fdata%2Fcocoa%2Fcocoa-hard.jsonR2i10443R3R4R5R39R6tgoR0y34:assets%2Fdata%2Fcocoa%2Fcocoa.jsonR2i8278R3R4R5R40R6tgoR0y35:assets%2Fdata%2Fcocoa%2Fevents.jsonR2i3644R3R4R5R41R6tgoR0y49:assets%2Fdata%2Fdad-battle%2Fdad-battle-easy.jsonR2i7937R3R4R5R42R6tgoR0y49:assets%2Fdata%2Fdad-battle%2Fdad-battle-hard.jsonR2i9756R3R4R5R43R6tgoR0y44:assets%2Fdata%2Fdad-battle%2Fdad-battle.jsonR2i8913R3R4R5R44R6tgoR0y34:assets%2Fdata%2Fdata-goes-here.txtR2zR3R4R5R45R6tgoR0y41:assets%2Fdata%2Feggnog%2Feggnog-easy.jsonR2i9239R3R4R5R46R6tgoR0y41:assets%2Fdata%2Feggnog%2Feggnog-hard.jsonR2i11689R3R4R5R47R6tgoR0y36:assets%2Fdata%2Feggnog%2Feggnog.jsonR2i10333R3R4R5R48R6tgoR0y36:assets%2Fdata%2Feggnog%2Fevents.jsonR2i4881R3R4R5R49R6tgoR0y34:assets%2Fdata%2FfreeplayColors.txtR2i76R3R4R5R50R6tgoR0y35:assets%2Fdata%2Ffresh%2Fevents.jsonR2i3201R3R4R5R51R6tgoR0y39:assets%2Fdata%2Ffresh%2Ffresh-easy.jsonR2i5857R3R4R5R52R6tgoR0y39:assets%2Fdata%2Ffresh%2Ffresh-hard.jsonR2i6905R3R4R5R53R6tgoR0y34:assets%2Fdata%2Ffresh%2Ffresh.jsonR2i6493R3R4R5R54R6tgoR0y34:assets%2Fdata%2Fhigh%2Fevents.jsonR2i4558R3R4R5R55R6tgoR0y37:assets%2Fdata%2Fhigh%2Fhigh-easy.jsonR2i8563R3R4R5R56R6tgoR0y37:assets%2Fdata%2Fhigh%2Fhigh-hard.jsonR2i11553R3R4R5R57R6tgoR0y32:assets%2Fdata%2Fhigh%2Fhigh.jsonR2i9757R3R4R5R58R6tgoR0y29:assets%2Fdata%2FintroText.txtR2i2130R3R4R5R59R6tgoR0y29:assets%2Fdata%2Fmain-view.xmlR2i123R3R4R5R60R6tgoR0y34:assets%2Fdata%2Fmilf%2Fevents.jsonR2i7488R3R4R5R61R6tgoR0y37:assets%2Fdata%2Fmilf%2Fmilf-easy.jsonR2i13522R3R4R5R62R6tgoR0y37:assets%2Fdata%2Fmilf%2Fmilf-hard.jsonR2i18135R3R4R5R63R6tgoR0y32:assets%2Fdata%2Fmilf%2Fmilf.jsonR2i15192R3R4R5R64R6tgoR0y43:assets%2Fdata%2Fmonster%2Fmonster-easy.jsonR2i12175R3R4R5R65R6tgoR0y43:assets%2Fdata%2Fmonster%2Fmonster-hard.jsonR2i14163R3R4R5R66R6tgoR0y38:assets%2Fdata%2Fmonster%2Fmonster.jsonR2i13445R3R4R5R67R6tgoR0y41:assets%2Fdata%2Fphilly-nice%2Fevents.jsonR2i5191R3R4R5R68R6tgoR0y51:assets%2Fdata%2Fphilly-nice%2Fphilly-nice-easy.jsonR2i8067R3R4R5R69R6tgoR0y51:assets%2Fdata%2Fphilly-nice%2Fphilly-nice-hard.jsonR2i12556R3R4R5R70R6tgoR0y46:assets%2Fdata%2Fphilly-nice%2Fphilly-nice.jsonR2i10103R3R4R5R71R6tgoR0y37:assets%2Fdata%2Fpico%2Fpico-easy.jsonR2i6089R3R4R5R72R6tgoR0y37:assets%2Fdata%2Fpico%2Fpico-hard.jsonR2i8768R3R4R5R73R6tgoR0y32:assets%2Fdata%2Fpico%2Fpico.jsonR2i7493R3R4R5R74R6tgoR0y34:assets%2Fdata%2Fridge%2Fridge.jsonR2i34473R3R4R5R75R6tgoR0y35:assets%2Fdata%2Froses%2Fevents.jsonR2i8786R3R4R5R76R6tgoR0y39:assets%2Fdata%2Froses%2Froses-easy.jsonR2i6725R3R4R5R77R6tgoR0y39:assets%2Fdata%2Froses%2Froses-hard.jsonR2i10432R3R4R5R78R6tgoR0y34:assets%2Fdata%2Froses%2Froses.jsonR2i8609R3R4R5R79R6tgoR0y41:assets%2Fdata%2Froses%2FrosesDialogue.txtR2i153R3R4R5R80R6tgoR0y43:assets%2Fdata%2Fsatin-panties%2Fevents.jsonR2i3177R3R4R5R81R6tgoR0y55:assets%2Fdata%2Fsatin-panties%2Fsatin-panties-easy.jsonR2i8817R3R4R5R82R6tgoR0y55:assets%2Fdata%2Fsatin-panties%2Fsatin-panties-hard.jsonR2i12704R3R4R5R83R6tgoR0y50:assets%2Fdata%2Fsatin-panties%2Fsatin-panties.jsonR2i10725R3R4R5R84R6tgoR0y41:assets%2Fdata%2Fsenpai%2Fsenpai-easy.jsonR2i9027R3R4R5R85R6tgoR0y41:assets%2Fdata%2Fsenpai%2Fsenpai-hard.jsonR2i10778R3R4R5R86R6tgoR0y36:assets%2Fdata%2Fsenpai%2Fsenpai.jsonR2i10016R3R4R5R87R6tgoR0y43:assets%2Fdata%2Fsenpai%2FsenpaiDialogue.txtR2i162R3R4R5R88R6tgoR0y34:assets%2Fdata%2Fsmash%2Fsmash.jsonR2i23961R3R4R5R89R6tgoR0y39:assets%2Fdata%2Fsouth%2Fsouth-easy.jsonR2i8435R3R4R5R90R6tgoR0y39:assets%2Fdata%2Fsouth%2Fsouth-hard.jsonR2i10170R3R4R5R91R6tgoR0y34:assets%2Fdata%2Fsouth%2Fsouth.jsonR2i10097R3R4R5R92R6tgoR0y33:assets%2Fdata%2FspecialThanks.txtR2i300R3R4R5R93R6tgoR0y45:assets%2Fdata%2Fspookeez%2Fspookeez-easy.jsonR2i7965R3R4R5R94R6tgoR0y45:assets%2Fdata%2Fspookeez%2Fspookeez-hard.jsonR2i9429R3R4R5R95R6tgoR0y40:assets%2Fdata%2Fspookeez%2Fspookeez.jsonR2i8875R3R4R5R96R6tgoR0y29:assets%2Fdata%2FstageList.txtR2i56R3R4R5R97R6tgoR0y32:assets%2Fdata%2Ftest%2Ftest.jsonR2i12411R3R4R5R98R6tgoR0y36:assets%2Fdata%2Fthorns%2Fevents.jsonR2i8104R3R4R5R99R6tgoR0y41:assets%2Fdata%2Fthorns%2Fthorns-easy.jsonR2i10437R3R4R5R100R6tgoR0y41:assets%2Fdata%2Fthorns%2Fthorns-hard.jsonR2i15444R3R4R5R101R6tgoR0y36:assets%2Fdata%2Fthorns%2Fthorns.jsonR2i12691R3R4R5R102R6tgoR0y43:assets%2Fdata%2Fthorns%2FthornsDialogue.txtR2i305R3R4R5R103R6tgoR0y38:assets%2Fdata%2Ftutorial%2Fevents.jsonR2i2702R3R4R5R104R6tgoR0y45:assets%2Fdata%2Ftutorial%2Ftutorial-easy.jsonR2i5739R3R4R5R105R6tgoR0y45:assets%2Fdata%2Ftutorial%2Ftutorial-hard.jsonR2i6335R3R4R5R106R6tgoR0y40:assets%2Fdata%2Ftutorial%2Ftutorial.jsonR2i5739R3R4R5R107R6tgoR0y47:assets%2Fdata%2Fwinter-horrorland%2Fevents.jsonR2i6197R3R4R5R108R6tgoR0y63:assets%2Fdata%2Fwinter-horrorland%2Fwinter-horrorland-easy.jsonR2i11846R3R4R5R109R6tgoR0y63:assets%2Fdata%2Fwinter-horrorland%2Fwinter-horrorland-hard.jsonR2i14558R3R4R5R110R6tgoR0y58:assets%2Fdata%2Fwinter-horrorland%2Fwinter-horrorland.jsonR2i12808R3R4R5R111R6tgoR0y37:assets%2Fimages%2Fachievementgrid.pngR2i263971R3y5:IMAGER5R112R6tgoR0y30:assets%2Fimages%2Falphabet.pngR2i187033R3R113R5R114R6tgoR0y30:assets%2Fimages%2Falphabet.xmlR2i52093R3R4R5R115R6tgoR0y45:assets%2Fimages%2Fcampaign_menu_UI_assets.pngR2i7511R3R113R5R116R6tgoR0y45:assets%2Fimages%2Fcampaign_menu_UI_assets.xmlR2i597R3R4R5R117R6tgoR0y44:assets%2Fimages%2Fcharacters%2FBOYFRIEND.pngR2i2639470R3R113R5R118R6tgoR0y44:assets%2Fimages%2Fcharacters%2FBOYFRIEND.xmlR2i67721R3R4R5R119R6tgoR0y33:assets%2Fimages%2Fchart_quant.pngR2i2593R3R113R5R120R6tgoR0y33:assets%2Fimages%2Fchart_quant.xmlR2i582R3R4R5R121R6tgoR0y34:assets%2Fimages%2Fcheckboxanim.pngR2i42746R3R113R5R122R6tgoR0y34:assets%2Fimages%2Fcheckboxanim.xmlR2i1976R3R4R5R123R6tgoR0y40:assets%2Fimages%2Fcredits%2Fbb-panzu.pngR2i4703R3R113R5R124R6tgoR0y39:assets%2Fimages%2Fcredits%2Fdiscord.pngR2i3505R3R113R5R125R6tgoR0y40:assets%2Fimages%2Fcredits%2Fevilsk8r.pngR2i7602R3R113R5R126R6tgoR0y36:assets%2Fimages%2Fcredits%2Fg3yt.pngR2i21251R3R113R5R127R6tgoR0y40:assets%2Fimages%2Fcredits%2Fgedehari.pngR2i5983R3R113R5R128R6tgoR0y39:assets%2Fimages%2Fcredits%2Fiflicky.pngR2i7191R3R113R5R129R6tgoR0y43:assets%2Fimages%2Fcredits%2Fkawaisprite.pngR2i3871R3R113R5R130R6tgoR0y38:assets%2Fimages%2Fcredits%2Fkeoiki.pngR2i4291R3R113R5R131R6tgoR0y40:assets%2Fimages%2Fcredits%2Fmajigsaw.pngR2i8738R3R113R5R132R6tgoR0y45:assets%2Fimages%2Fcredits%2Fninjamuffin99.pngR2i4336R3R113R5R133R6tgoR0y45:assets%2Fimages%2Fcredits%2Fphantomarcade.pngR2i7875R3R113R5R134R6tgoR0y45:assets%2Fimages%2Fcredits%2Fpolybiusproxy.pngR2i8864R3R113R5R135R6tgoR0y42:assets%2Fimages%2Fcredits%2Friveroaken.pngR2i6881R3R113R5R136R6tgoR0y43:assets%2Fimages%2Fcredits%2Fshadowmario.pngR2i3081R3R113R5R137R6tgoR0y37:assets%2Fimages%2Fcredits%2Fshubs.pngR2i9626R3R113R5R138R6tgoR0y42:assets%2Fimages%2Fcredits%2Funstop4ble.pngR2i20543R3R113R5R139R6tgoR0y34:assets%2Fimages%2Fcry_about_it.pngR2i380631R3R113R5R140R6tgoR0y36:assets%2Fimages%2Fdialogue%2Fbf.jsonR2i987R3R4R5R141R6tgoR0y36:assets%2Fimages%2Fdialogue%2Fgf.jsonR2i807R3R4R5R142R6tgoR0y28:assets%2Fimages%2Ffunkay.pngR2i135548R3R113R5R143R6tgoR0y35:assets%2Fimages%2FgfDanceTitle.jsonR2i124R3R4R5R144R6tgoR0y34:assets%2Fimages%2FgfDanceTitle.pngR2i1221436R3R113R5R145R6tgoR0y34:assets%2Fimages%2FgfDanceTitle.xmlR2i4259R3R4R5R146R6tgoR0y30:assets%2Fimages%2Fhahadumb.pngR2i16097R3R113R5R147R6tgoR0y27:assets%2Fimages%2FhugeW.pngR2i18069R3R113R5R148R6tgoR0y38:assets%2Fimages%2FHURTnoteSplashes.pngR2i62608R3R113R5R149R6tgoR0y38:assets%2Fimages%2FHURTnoteSplashes.xmlR2i4857R3R4R5R150R6tgoR0y37:assets%2Fimages%2FHURTNOTE_assets.pngR2i26086R3R113R5R151R6tgoR0y37:assets%2Fimages%2FHURTNOTE_assets.xmlR2i1116R3R4R5R152R6tgoR0y41:assets%2Fimages%2Ficons%2Ficon-bf-old.pngR2i10263R3R113R5R153R6tgoR0y43:assets%2Fimages%2Ficons%2Ficon-bf-pixel.pngR2i1221R3R113R5R154R6tgoR0y37:assets%2Fimages%2Ficons%2Ficon-bf.pngR2i19936R3R113R5R155R6tgoR0y38:assets%2Fimages%2Ficons%2Ficon-dad.pngR2i14488R3R113R5R156R6tgoR0y39:assets%2Fimages%2Ficons%2Ficon-face.pngR2i7096R3R113R5R157R6tgoR0y37:assets%2Fimages%2Ficons%2Ficon-gf.pngR2i11992R3R113R5R158R6tgoR0y38:assets%2Fimages%2Ficons%2Ficon-mom.pngR2i15612R3R113R5R159R6tgoR0y42:assets%2Fimages%2Ficons%2Ficon-monster.pngR2i23064R3R113R5R160R6tgoR0y42:assets%2Fimages%2Ficons%2Ficon-parents.pngR2i19196R3R113R5R161R6tgoR0y39:assets%2Fimages%2Ficons%2Ficon-pico.pngR2i21559R3R113R5R162R6tgoR0y47:assets%2Fimages%2Ficons%2Ficon-senpai-pixel.pngR2i1377R3R113R5R163R6tgoR0y47:assets%2Fimages%2Ficons%2Ficon-spirit-pixel.pngR2i1278R3R113R5R164R6tgoR0y41:assets%2Fimages%2Ficons%2Ficon-spooky.pngR2i10457R3R113R5R165R6tgoR0y42:assets%2Fimages%2Ficons%2Ficon-tankman.pngR2i7072R3R113R5R166R6tgoR0y39:assets%2Fimages%2Flockedachievement.pngR2i13055R3R113R5R167R6tgoR0y26:assets%2Fimages%2Flogo.pngR2i86924R3R113R5R168R6tgoR0y32:assets%2Fimages%2FlogoBumpin.pngR2i592724R3R113R5R169R6tgoR0y32:assets%2Fimages%2FlogoBumpin.xmlR2i2177R3R4R5R170R6tgoR0y44:assets%2Fimages%2Fmainmenu%2Fmenu_awards.pngR2i67591R3R113R5R171R6tgoR0y44:assets%2Fimages%2Fmainmenu%2Fmenu_awards.xmlR2i1380R3R4R5R172R6tgoR0y45:assets%2Fimages%2Fmainmenu%2Fmenu_credits.pngR2i69937R3R113R5R173R6tgoR0y45:assets%2Fimages%2Fmainmenu%2Fmenu_credits.xmlR2i1385R3R4R5R174R6tgoR0y44:assets%2Fimages%2Fmainmenu%2Fmenu_donate.pngR2i58703R3R113R5R175R6tgoR0y44:assets%2Fimages%2Fmainmenu%2Fmenu_donate.xmlR2i1375R3R4R5R176R6tgoR0y46:assets%2Fimages%2Fmainmenu%2Fmenu_freeplay.pngR2i71504R3R113R5R177R6tgoR0y46:assets%2Fimages%2Fmainmenu%2Fmenu_freeplay.xmlR2i1399R3R4R5R178R6tgoR0y42:assets%2Fimages%2Fmainmenu%2Fmenu_mods.pngR2i54051R3R113R5R179R6tgoR0y42:assets%2Fimages%2Fmainmenu%2Fmenu_mods.xmlR2i1644R3R4R5R180R6tgoR0y45:assets%2Fimages%2Fmainmenu%2Fmenu_options.pngR2i66084R3R113R5R181R6tgoR0y45:assets%2Fimages%2Fmainmenu%2Fmenu_options.xmlR2i1332R3R4R5R182R6tgoR0y48:assets%2Fimages%2Fmainmenu%2Fmenu_story_mode.pngR2i119619R3R113R5R183R6tgoR0y48:assets%2Fimages%2Fmainmenu%2Fmenu_story_mode.xmlR2i1444R3R4R5R184R6tgoR0y54:assets%2Fimages%2Fmenubackgrounds%2Fmenu_christmas.pngR2i38977R3R113R5R185R6tgoR0y54:assets%2Fimages%2Fmenubackgrounds%2Fmenu_halloween.pngR2i19784R3R113R5R186R6tgoR0y49:assets%2Fimages%2Fmenubackgrounds%2Fmenu_limo.pngR2i15191R3R113R5R187R6tgoR0y51:assets%2Fimages%2Fmenubackgrounds%2Fmenu_philly.pngR2i46318R3R113R5R188R6tgoR0y51:assets%2Fimages%2Fmenubackgrounds%2Fmenu_school.pngR2i6974R3R113R5R189R6tgoR0y50:assets%2Fimages%2Fmenubackgrounds%2Fmenu_stage.pngR2i54688R3R113R5R190R6tgoR0y28:assets%2Fimages%2FmenuBG.pngR2i620342R3R113R5R191R6tgoR0y32:assets%2Fimages%2FmenuBGBlue.pngR2i614586R3R113R5R192R6tgoR0y35:assets%2Fimages%2FmenuBGMagenta.pngR2i553468R3R113R5R193R6tgoR0y42:assets%2Fimages%2Fmenucharacters%2Fbf.jsonR2i125R3R4R5R194R6tgoR0y43:assets%2Fimages%2Fmenucharacters%2Fdad.jsonR2i126R3R4R5R195R6tgoR0y42:assets%2Fimages%2Fmenucharacters%2Fgf.jsonR2i125R3R4R5R196R6tgoR0y46:assets%2Fimages%2Fmenucharacters%2FMenu_BF.pngR2i208834R3R113R5R197R6tgoR0y46:assets%2Fimages%2Fmenucharacters%2FMenu_BF.xmlR2i5582R3R4R5R198R6tgoR0y47:assets%2Fimages%2Fmenucharacters%2FMenu_Dad.pngR2i116690R3R113R5R199R6tgoR0y47:assets%2Fimages%2Fmenucharacters%2FMenu_Dad.xmlR2i2115R3R4R5R200R6tgoR0y46:assets%2Fimages%2Fmenucharacters%2FMenu_GF.pngR2i330213R3R113R5R201R6tgoR0y46:assets%2Fimages%2Fmenucharacters%2FMenu_GF.xmlR2i3802R3R4R5R202R6tgoR0y47:assets%2Fimages%2Fmenucharacters%2FMenu_Mom.pngR2i156895R3R113R5R203R6tgoR0y47:assets%2Fimages%2Fmenucharacters%2FMenu_Mom.xmlR2i2113R3R4R5R204R6tgoR0y51:assets%2Fimages%2Fmenucharacters%2FMenu_Parents.pngR2i351693R3R113R5R205R6tgoR0y51:assets%2Fimages%2Fmenucharacters%2FMenu_Parents.xmlR2i2188R3R4R5R206R6tgoR0y48:assets%2Fimages%2Fmenucharacters%2FMenu_Pico.pngR2i113929R3R113R5R207R6tgoR0y48:assets%2Fimages%2Fmenucharacters%2FMenu_Pico.xmlR2i2142R3R4R5R208R6tgoR0y50:assets%2Fimages%2Fmenucharacters%2FMenu_Senpai.pngR2i66773R3R113R5R209R6tgoR0y50:assets%2Fimages%2Fmenucharacters%2FMenu_Senpai.xmlR2i1348R3R4R5R210R6tgoR0y55:assets%2Fimages%2Fmenucharacters%2FMenu_Spooky_Kids.pngR2i81655R3R113R5R211R6tgoR0y55:assets%2Fimages%2Fmenucharacters%2FMenu_Spooky_Kids.xmlR2i2543R3R4R5R212R6tgoR0y43:assets%2Fimages%2Fmenucharacters%2Fmom.jsonR2i125R3R4R5R213R6tgoR0y57:assets%2Fimages%2Fmenucharacters%2Fparents-christmas.jsonR2i135R3R4R5R214R6tgoR0y44:assets%2Fimages%2Fmenucharacters%2Fpico.jsonR2i129R3R4R5R215R6tgoR0y46:assets%2Fimages%2Fmenucharacters%2Fsenpai.jsonR2i133R3R4R5R216R6tgoR0y46:assets%2Fimages%2Fmenucharacters%2Fspooky.jsonR2i142R3R4R5R217R6tgoR0y31:assets%2Fimages%2FmenuDesat.pngR2i357911R3R113R5R218R6tgoR0y45:assets%2Fimages%2Fmenudifficulties%2Feasy.pngR2i3453R3R113R5R219R6tgoR0y45:assets%2Fimages%2Fmenudifficulties%2Fhard.pngR2i3880R3R113R5R220R6tgoR0y47:assets%2Fimages%2Fmenudifficulties%2Fnormal.pngR2i4853R3R113R5R221R6tgoR0y33:assets%2Fimages%2FMenu_Tracks.pngR2i3487R3R113R5R222R6tgoR0y37:assets%2Fimages%2Fnewgrounds_logo.pngR2i57747R3R113R5R223R6tgoR0y34:assets%2Fimages%2FnoteSplashes.pngR2i203739R3R113R5R224R6tgoR0y34:assets%2Fimages%2FnoteSplashes.xmlR2i4673R3R4R5R225R6tgoR0y33:assets%2Fimages%2FNOTE_assets.pngR2i129989R3R113R5R226R6tgoR0y33:assets%2Fimages%2FNOTE_assets.xmlR2i8175R3R4R5R227R6tgoR0y26:assets%2Fimages%2Fnum0.pngR2i3738R3R113R5R228R6tgoR0y26:assets%2Fimages%2Fnum1.pngR2i3390R3R113R5R229R6tgoR0y26:assets%2Fimages%2Fnum2.pngR2i3990R3R113R5R230R6tgoR0y26:assets%2Fimages%2Fnum3.pngR2i4022R3R113R5R231R6tgoR0y26:assets%2Fimages%2Fnum4.pngR2i3989R3R113R5R232R6tgoR0y26:assets%2Fimages%2Fnum5.pngR2i4113R3R113R5R233R6tgoR0y26:assets%2Fimages%2Fnum6.pngR2i4181R3R113R5R234R6tgoR0y26:assets%2Fimages%2Fnum7.pngR2i3692R3R113R5R235R6tgoR0y26:assets%2Fimages%2Fnum8.pngR2i3914R3R113R5R236R6tgoR0y26:assets%2Fimages%2Fnum9.pngR2i3687R3R113R5R237R6tgoR0y41:assets%2Fimages%2FpixelUI%2Fbad-pixel.pngR2i418R3R113R5R238R6tgoR0y43:assets%2Fimages%2FpixelUI%2Fcombo-pixel.pngR2i417R3R113R5R239R6tgoR0y42:assets%2Fimages%2FpixelUI%2Fdate-pixel.pngR2i1055R3R113R5R240R6tgoR0y42:assets%2Fimages%2FpixelUI%2Fgood-pixel.pngR2i396R3R113R5R241R6tgoR0y47:assets%2Fimages%2FpixelUI%2FHURTNOTE_assets.pngR2i1586R3R113R5R242R6tgoR0y51:assets%2Fimages%2FpixelUI%2FHURTNOTE_assetsENDS.pngR2i228R3R113R5R243R6tgoR0y43:assets%2Fimages%2FpixelUI%2FNOTE_assets.pngR2i4806R3R113R5R244R6tgoR0y47:assets%2Fimages%2FpixelUI%2FNOTE_assetsENDS.pngR2i357R3R113R5R245R6tgoR0y42:assets%2Fimages%2FpixelUI%2Fnum0-pixel.pngR2i189R3R113R5R246R6tgoR0y42:assets%2Fimages%2FpixelUI%2Fnum1-pixel.pngR2i169R3R113R5R247R6tgoR0y42:assets%2Fimages%2FpixelUI%2Fnum2-pixel.pngR2i220R3R113R5R248R6tgoR0y42:assets%2Fimages%2FpixelUI%2Fnum3-pixel.pngR2i204R3R113R5R249R6tgoR0y42:assets%2Fimages%2FpixelUI%2Fnum4-pixel.pngR2i181R3R113R5R250R6tgoR0y42:assets%2Fimages%2FpixelUI%2Fnum5-pixel.pngR2i203R3R113R5R251R6tgoR0y42:assets%2Fimages%2FpixelUI%2Fnum6-pixel.pngR2i214R3R113R5R252R6tgoR0y42:assets%2Fimages%2FpixelUI%2Fnum7-pixel.pngR2i197R3R113R5R253R6tgoR0y42:assets%2Fimages%2FpixelUI%2Fnum8-pixel.pngR2i187R3R113R5R254R6tgoR0y42:assets%2Fimages%2FpixelUI%2Fnum9-pixel.pngR2i176R3R113R5R255R6tgoR0y43:assets%2Fimages%2FpixelUI%2Fready-pixel.pngR2i1092R3R113R5R256R6tgoR0y41:assets%2Fimages%2FpixelUI%2Fset-pixel.pngR2i1068R3R113R5R257R6tgoR0y42:assets%2Fimages%2FpixelUI%2Fshit-pixel.pngR2i628R3R113R5R258R6tgoR0y42:assets%2Fimages%2FpixelUI%2Fsick-pixel.pngR2i553R3R113R5R259R6tgoR0y42:assets%2Fimages%2Fstorymenu%2Ftutorial.pngR2i7056R3R113R5R260R6tgoR0y39:assets%2Fimages%2Fstorymenu%2Fweek1.pngR2i6261R3R113R5R261R6tgoR0y39:assets%2Fimages%2Fstorymenu%2Fweek2.pngR2i6517R3R113R5R262R6tgoR0y39:assets%2Fimages%2Fstorymenu%2Fweek3.pngR2i7148R3R113R5R263R6tgoR0y39:assets%2Fimages%2Fstorymenu%2Fweek4.pngR2i6262R3R113R5R264R6tgoR0y39:assets%2Fimages%2Fstorymenu%2Fweek5.pngR2i6440R3R113R5R265R6tgoR0y39:assets%2Fimages%2Fstorymenu%2Fweek6.pngR2i8979R3R113R5R266R6tgoR0y32:assets%2Fimages%2FtitleEnter.pngR2i1449202R3R113R5R267R6tgoR0y32:assets%2Fimages%2FtitleEnter.xmlR2i4875R3R4R5R268R6tgoR0y41:assets%2Fimages%2Fui%2Fbutt_graph0001.pngR2i432R3R113R5R269R6tgoR0y41:assets%2Fimages%2Fui%2Fbutt_graph0002.pngR2i421R3R113R5R270R6tgoR0y41:assets%2Fimages%2Fui%2Fbutt_graph0003.pngR2i612R3R113R5R271R6tgoR0y41:assets%2Fimages%2Fui%2Fbutt_graph0004.pngR2i890R3R113R5R272R6tgoR0y41:assets%2Fimages%2Fui%2Fbutt_graph0005.pngR2i907R3R113R5R273R6tgoR0y32:assets%2Fimages%2FunknownMod.pngR2i4493R3R113R5R274R6tgoR0y32:assets%2Fimages%2Fvirtualpad.pngR2i348990R3R113R5R275R6tgoR0y32:assets%2Fimages%2Fvirtualpad.txtR2i318R3R4R5R276R6tgoR2i2309657R3y5:MUSICR5y31:assets%2Fmusic%2FfreakyMenu.mp3y9:pathGroupaR278hR6tgoR2i2402257R3R277R5y31:assets%2Fmusic%2FoffsetSong.mp3R279aR280hR6tgoR2i17762R3R277R5y32:assets%2Fsounds%2FcancelMenu.mp3R279aR281hR6tgoR2i91950R3R277R5y33:assets%2Fsounds%2FconfirmMenu.mp3R279aR282hR6tgoR2i9155R3R277R5y34:assets%2Fsounds%2Fintro1-pixel.mp3R279aR283hR6tgoR2i9912R3R277R5y34:assets%2Fsounds%2Fintro2-pixel.mp3R279aR284hR6tgoR2i9128R3R277R5y34:assets%2Fsounds%2Fintro3-pixel.mp3R279aR285hR6tgoR2i21651R3R277R5y35:assets%2Fsounds%2FintroGo-pixel.mp3R279aR286hR6tgoR2i17762R3R277R5y32:assets%2Fsounds%2FscrollMenu.mp3R279aR287hR6tgoR2i42970R3R277R5y33:assets%2Fsounds%2FsecretSound.mp3R279aR288hR6tgoR0y27:assets%2Fstages%2Flimo.jsonR2i151R3R4R5R289R6tgoR0y27:assets%2Fstages%2Fmall.jsonR2i149R3R4R5R290R6tgoR0y31:assets%2Fstages%2FmallEvil.jsonR2i150R3R4R5R291R6tgoR0y29:assets%2Fstages%2Fphilly.jsonR2i150R3R4R5R292R6tgoR0y29:assets%2Fstages%2Fschool.jsonR2i149R3R4R5R293R6tgoR0y33:assets%2Fstages%2FschoolEvil.jsonR2i149R3R4R5R294R6tgoR0y29:assets%2Fstages%2Fspooky.jsonR2i150R3R4R5R295R6tgoR0y28:assets%2Fstages%2Fstage.jsonR2i144R3R4R5R296R6tgoR0y30:assets%2Fweeks%2Ftutorial.jsonR2i274R3R4R5R297R6tgoR0y27:assets%2Fweeks%2Fweek1.jsonR2i369R3R4R5R298R6tgoR0y27:assets%2Fweeks%2Fweek2.jsonR2i371R3R4R5R299R6tgoR0y27:assets%2Fweeks%2Fweek3.jsonR2i356R3R4R5R300R6tgoR0y27:assets%2Fweeks%2Fweek4.jsonR2i369R3R4R5R301R6tgoR0y27:assets%2Fweeks%2Fweek5.jsonR2i397R3R4R5R302R6tgoR0y27:assets%2Fweeks%2Fweek6.jsonR2i408R3R4R5R303R6tgoR0y29:assets%2Fweeks%2FweekList.txtR2i44R3R4R5R304R6tgoR0y21:do%20NOT%20readme.txtR2i4326R3R4R5R305R6tgoR0y34:assets%2Ffonts%2Ffonts-go-here.txtR2zR3R4R5R306R6tgoR2i14656R3y4:FONTy9:classNamey31:__ASSET__assets_fonts_pixel_otfR5y26:assets%2Ffonts%2Fpixel.otfR6tgoR2i75864R3R307R308y29:__ASSET__assets_fonts_vcr_ttfR5y24:assets%2Ffonts%2Fvcr.ttfR6tgoR2i2114R3R277R5y26:flixel%2Fsounds%2Fbeep.mp3R279aR313y26:flixel%2Fsounds%2Fbeep.ogghR6tgoR2i39706R3R277R5y28:flixel%2Fsounds%2Fflixel.mp3R279aR315y28:flixel%2Fsounds%2Fflixel.ogghR6tgoR2i5794R3y5:SOUNDR5R314R279aR313R314hgoR2i33629R3R317R5R316R279aR315R316hgoR2i15744R3R307R308y35:__ASSET__flixel_fonts_nokiafc22_ttfR5y30:flixel%2Ffonts%2Fnokiafc22.ttfR6tgoR2i29724R3R307R308y36:__ASSET__flixel_fonts_monsterrat_ttfR5y31:flixel%2Ffonts%2Fmonsterrat.ttfR6tgoR0y33:flixel%2Fimages%2Fui%2Fbutton.pngR2i519R3R113R5R322R6tgoR0y36:flixel%2Fimages%2Flogo%2Fdefault.pngR2i3280R3R113R5R323R6tgoR0y34:flixel%2Fflixel-ui%2Fimg%2Fbox.pngR2i912R3R113R5R324R6tgoR0y37:flixel%2Fflixel-ui%2Fimg%2Fbutton.pngR2i433R3R113R5R325R6tgoR0y48:flixel%2Fflixel-ui%2Fimg%2Fbutton_arrow_down.pngR2i446R3R113R5R326R6tgoR0y48:flixel%2Fflixel-ui%2Fimg%2Fbutton_arrow_left.pngR2i459R3R113R5R327R6tgoR0y49:flixel%2Fflixel-ui%2Fimg%2Fbutton_arrow_right.pngR2i511R3R113R5R328R6tgoR0y46:flixel%2Fflixel-ui%2Fimg%2Fbutton_arrow_up.pngR2i493R3R113R5R329R6tgoR0y42:flixel%2Fflixel-ui%2Fimg%2Fbutton_thin.pngR2i247R3R113R5R330R6tgoR0y44:flixel%2Fflixel-ui%2Fimg%2Fbutton_toggle.pngR2i534R3R113R5R331R6tgoR0y40:flixel%2Fflixel-ui%2Fimg%2Fcheck_box.pngR2i922R3R113R5R332R6tgoR0y41:flixel%2Fflixel-ui%2Fimg%2Fcheck_mark.pngR2i946R3R113R5R333R6tgoR0y37:flixel%2Fflixel-ui%2Fimg%2Fchrome.pngR2i253R3R113R5R334R6tgoR0y42:flixel%2Fflixel-ui%2Fimg%2Fchrome_flat.pngR2i212R3R113R5R335R6tgoR0y43:flixel%2Fflixel-ui%2Fimg%2Fchrome_inset.pngR2i192R3R113R5R336R6tgoR0y43:flixel%2Fflixel-ui%2Fimg%2Fchrome_light.pngR2i214R3R113R5R337R6tgoR0y44:flixel%2Fflixel-ui%2Fimg%2Fdropdown_mark.pngR2i156R3R113R5R338R6tgoR0y41:flixel%2Fflixel-ui%2Fimg%2Ffinger_big.pngR2i1724R3R113R5R339R6tgoR0y43:flixel%2Fflixel-ui%2Fimg%2Ffinger_small.pngR2i294R3R113R5R340R6tgoR0y38:flixel%2Fflixel-ui%2Fimg%2Fhilight.pngR2i129R3R113R5R341R6tgoR0y36:flixel%2Fflixel-ui%2Fimg%2Finvis.pngR2i128R3R113R5R342R6tgoR0y41:flixel%2Fflixel-ui%2Fimg%2Fminus_mark.pngR2i136R3R113R5R343R6tgoR0y40:flixel%2Fflixel-ui%2Fimg%2Fplus_mark.pngR2i147R3R113R5R344R6tgoR0y36:flixel%2Fflixel-ui%2Fimg%2Fradio.pngR2i191R3R113R5R345R6tgoR0y40:flixel%2Fflixel-ui%2Fimg%2Fradio_dot.pngR2i153R3R113R5R346R6tgoR0y37:flixel%2Fflixel-ui%2Fimg%2Fswatch.pngR2i185R3R113R5R347R6tgoR0y34:flixel%2Fflixel-ui%2Fimg%2Ftab.pngR2i201R3R113R5R348R6tgoR0y39:flixel%2Fflixel-ui%2Fimg%2Ftab_back.pngR2i210R3R113R5R349R6tgoR0y44:flixel%2Fflixel-ui%2Fimg%2Ftooltip_arrow.pngR2i18509R3R113R5R350R6tgoR0y39:flixel%2Fflixel-ui%2Fxml%2Fdefaults.xmlR2i1263R3R4R5R351R6tgoR0y53:flixel%2Fflixel-ui%2Fxml%2Fdefault_loading_screen.xmlR2i1953R3R4R5R352R6tgoR0y44:flixel%2Fflixel-ui%2Fxml%2Fdefault_popup.xmlR2i1848R3R4R5R353R6tgh","rootPath":null,"version":2,"libraryArgs":[],"libraryType":null}';
		manifest = AssetManifest.parse (data, rootPath);
		library = AssetLibrary.fromManifest (manifest);
		Assets.registerLibrary ("default", library);
		

		library = Assets.getLibrary ("videos");
		if (library != null) preloadLibraries.push (library);
		else preloadLibraryNames.push ("videos");
		library = Assets.getLibrary ("default");
		if (library != null) preloadLibraries.push (library);
		else preloadLibraryNames.push ("default");
		

		#end

	}


}


#if kha

null

#else

#if !display
#if flash

@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_characters_bf_car_json extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_characters_bf_christmas_json extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_characters_bf_pixel_dead_json extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_characters_bf_pixel_opponent_json extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_characters_bf_pixel_json extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_characters_bf_json extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_characters_dad_json extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_characters_gf_car_json extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_characters_gf_christmas_json extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_characters_gf_pixel_json extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_characters_gf_json extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_characters_mom_car_json extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_characters_mom_json extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_characters_monster_christmas_json extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_characters_monster_json extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_characters_parents_christmas_json extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_characters_pico_player_json extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_characters_pico_json extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_characters_senpai_angry_json extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_characters_senpai_json extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_characters_spirit_json extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_characters_spooky_json extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_data_blammed_blammed_easy_json extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_data_blammed_blammed_hard_json extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_data_blammed_blammed_json extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_data_blammed_events_json extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_data_bopeebo_bopeebo_boobs_json extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_data_bopeebo_bopeebo_easy_json extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_data_bopeebo_bopeebo_hard_json extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_data_bopeebo_bopeebo_json extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_data_bopeebo_events_json extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_data_characterlist_txt extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_data_cocoa_cocoa_easy_json extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_data_cocoa_cocoa_hard_json extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_data_cocoa_cocoa_json extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_data_cocoa_events_json extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_data_dad_battle_dad_battle_easy_json extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_data_dad_battle_dad_battle_hard_json extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_data_dad_battle_dad_battle_json extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_data_data_goes_here_txt extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_data_eggnog_eggnog_easy_json extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_data_eggnog_eggnog_hard_json extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_data_eggnog_eggnog_json extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_data_eggnog_events_json extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_data_freeplaycolors_txt extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_data_fresh_events_json extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_data_fresh_fresh_easy_json extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_data_fresh_fresh_hard_json extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_data_fresh_fresh_json extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_data_high_events_json extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_data_high_high_easy_json extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_data_high_high_hard_json extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_data_high_high_json extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_data_introtext_txt extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_data_main_view_xml extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_data_milf_events_json extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_data_milf_milf_easy_json extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_data_milf_milf_hard_json extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_data_milf_milf_json extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_data_monster_monster_easy_json extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_data_monster_monster_hard_json extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_data_monster_monster_json extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_data_philly_nice_events_json extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_data_philly_nice_philly_nice_easy_json extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_data_philly_nice_philly_nice_hard_json extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_data_philly_nice_philly_nice_json extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_data_pico_pico_easy_json extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_data_pico_pico_hard_json extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_data_pico_pico_json extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_data_ridge_ridge_json extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_data_roses_events_json extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_data_roses_roses_easy_json extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_data_roses_roses_hard_json extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_data_roses_roses_json extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_data_roses_rosesdialogue_txt extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_data_satin_panties_events_json extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_data_satin_panties_satin_panties_easy_json extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_data_satin_panties_satin_panties_hard_json extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_data_satin_panties_satin_panties_json extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_data_senpai_senpai_easy_json extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_data_senpai_senpai_hard_json extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_data_senpai_senpai_json extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_data_senpai_senpaidialogue_txt extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_data_smash_smash_json extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_data_south_south_easy_json extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_data_south_south_hard_json extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_data_south_south_json extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_data_specialthanks_txt extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_data_spookeez_spookeez_easy_json extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_data_spookeez_spookeez_hard_json extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_data_spookeez_spookeez_json extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_data_stagelist_txt extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_data_test_test_json extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_data_thorns_events_json extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_data_thorns_thorns_easy_json extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_data_thorns_thorns_hard_json extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_data_thorns_thorns_json extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_data_thorns_thornsdialogue_txt extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_data_tutorial_events_json extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_data_tutorial_tutorial_easy_json extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_data_tutorial_tutorial_hard_json extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_data_tutorial_tutorial_json extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_data_winter_horrorland_events_json extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_data_winter_horrorland_winter_horrorland_easy_json extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_data_winter_horrorland_winter_horrorland_hard_json extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_data_winter_horrorland_winter_horrorland_json extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_achievementgrid_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_alphabet_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_alphabet_xml extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_campaign_menu_ui_assets_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_campaign_menu_ui_assets_xml extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_characters_boyfriend_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_characters_boyfriend_xml extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_chart_quant_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_chart_quant_xml extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_checkboxanim_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_checkboxanim_xml extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_credits_bb_panzu_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_credits_discord_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_credits_evilsk8r_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_credits_g3yt_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_credits_gedehari_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_credits_iflicky_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_credits_kawaisprite_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_credits_keoiki_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_credits_majigsaw_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_credits_ninjamuffin99_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_credits_phantomarcade_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_credits_polybiusproxy_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_credits_riveroaken_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_credits_shadowmario_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_credits_shubs_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_credits_unstop4ble_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_cry_about_it_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_dialogue_bf_json extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_dialogue_gf_json extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_funkay_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_gfdancetitle_json extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_gfdancetitle_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_gfdancetitle_xml extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_hahadumb_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_hugew_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_hurtnotesplashes_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_hurtnotesplashes_xml extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_hurtnote_assets_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_hurtnote_assets_xml extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_icons_icon_bf_old_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_icons_icon_bf_pixel_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_icons_icon_bf_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_icons_icon_dad_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_icons_icon_face_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_icons_icon_gf_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_icons_icon_mom_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_icons_icon_monster_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_icons_icon_parents_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_icons_icon_pico_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_icons_icon_senpai_pixel_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_icons_icon_spirit_pixel_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_icons_icon_spooky_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_icons_icon_tankman_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_lockedachievement_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_logo_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_logobumpin_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_logobumpin_xml extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_mainmenu_menu_awards_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_mainmenu_menu_awards_xml extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_mainmenu_menu_credits_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_mainmenu_menu_credits_xml extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_mainmenu_menu_donate_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_mainmenu_menu_donate_xml extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_mainmenu_menu_freeplay_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_mainmenu_menu_freeplay_xml extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_mainmenu_menu_mods_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_mainmenu_menu_mods_xml extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_mainmenu_menu_options_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_mainmenu_menu_options_xml extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_mainmenu_menu_story_mode_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_mainmenu_menu_story_mode_xml extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_menubackgrounds_menu_christmas_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_menubackgrounds_menu_halloween_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_menubackgrounds_menu_limo_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_menubackgrounds_menu_philly_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_menubackgrounds_menu_school_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_menubackgrounds_menu_stage_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_menubg_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_menubgblue_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_menubgmagenta_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_menucharacters_bf_json extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_menucharacters_dad_json extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_menucharacters_gf_json extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_menucharacters_menu_bf_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_menucharacters_menu_bf_xml extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_menucharacters_menu_dad_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_menucharacters_menu_dad_xml extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_menucharacters_menu_gf_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_menucharacters_menu_gf_xml extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_menucharacters_menu_mom_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_menucharacters_menu_mom_xml extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_menucharacters_menu_parents_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_menucharacters_menu_parents_xml extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_menucharacters_menu_pico_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_menucharacters_menu_pico_xml extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_menucharacters_menu_senpai_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_menucharacters_menu_senpai_xml extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_menucharacters_menu_spooky_kids_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_menucharacters_menu_spooky_kids_xml extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_menucharacters_mom_json extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_menucharacters_parents_christmas_json extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_menucharacters_pico_json extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_menucharacters_senpai_json extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_menucharacters_spooky_json extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_menudesat_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_menudifficulties_easy_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_menudifficulties_hard_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_menudifficulties_normal_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_menu_tracks_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_newgrounds_logo_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_notesplashes_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_notesplashes_xml extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_note_assets_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_note_assets_xml extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_num0_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_num1_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_num2_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_num3_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_num4_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_num5_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_num6_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_num7_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_num8_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_num9_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_pixelui_bad_pixel_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_pixelui_combo_pixel_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_pixelui_date_pixel_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_pixelui_good_pixel_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_pixelui_hurtnote_assets_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_pixelui_hurtnote_assetsends_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_pixelui_note_assets_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_pixelui_note_assetsends_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_pixelui_num0_pixel_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_pixelui_num1_pixel_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_pixelui_num2_pixel_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_pixelui_num3_pixel_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_pixelui_num4_pixel_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_pixelui_num5_pixel_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_pixelui_num6_pixel_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_pixelui_num7_pixel_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_pixelui_num8_pixel_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_pixelui_num9_pixel_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_pixelui_ready_pixel_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_pixelui_set_pixel_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_pixelui_shit_pixel_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_pixelui_sick_pixel_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_storymenu_tutorial_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_storymenu_week1_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_storymenu_week2_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_storymenu_week3_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_storymenu_week4_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_storymenu_week5_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_storymenu_week6_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_titleenter_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_titleenter_xml extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_ui_butt_graph0001_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_ui_butt_graph0002_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_ui_butt_graph0003_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_ui_butt_graph0004_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_ui_butt_graph0005_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_unknownmod_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_virtualpad_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_virtualpad_txt extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_music_freakymenu_mp3 extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_music_offsetsong_mp3 extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_sounds_cancelmenu_mp3 extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_sounds_confirmmenu_mp3 extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_sounds_intro1_pixel_mp3 extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_sounds_intro2_pixel_mp3 extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_sounds_intro3_pixel_mp3 extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_sounds_introgo_pixel_mp3 extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_sounds_scrollmenu_mp3 extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_sounds_secretsound_mp3 extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_stages_limo_json extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_stages_mall_json extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_stages_mallevil_json extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_stages_philly_json extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_stages_school_json extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_stages_schoolevil_json extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_stages_spooky_json extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_stages_stage_json extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_weeks_tutorial_json extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_weeks_week1_json extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_weeks_week2_json extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_weeks_week3_json extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_weeks_week4_json extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_weeks_week5_json extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_weeks_week6_json extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_weeks_weeklist_txt extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_videos_html_stuff_none_gif extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_videos_html_stuff_video_min_js extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_videos_put_your_videos_here_txt extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_songs_blammed_inst_mp3 extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_songs_blammed_voices_mp3 extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_songs_bopeebo_inst_mp3 extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_songs_bopeebo_voices_mp3 extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_songs_cocoa_inst_mp3 extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_songs_cocoa_voices_mp3 extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_songs_dad_battle_inst_mp3 extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_songs_dad_battle_voices_mp3 extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_songs_eggnog_inst_mp3 extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_songs_eggnog_voices_mp3 extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_songs_fresh_inst_mp3 extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_songs_fresh_voices_mp3 extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_songs_high_inst_mp3 extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_songs_high_voices_mp3 extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_songs_milf_inst_mp3 extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_songs_milf_voices_mp3 extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_songs_monster_inst_mp3 extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_songs_monster_voices_mp3 extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_songs_philly_nice_inst_mp3 extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_songs_philly_nice_voices_mp3 extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_songs_pico_inst_mp3 extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_songs_pico_voices_mp3 extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_songs_roses_inst_mp3 extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_songs_roses_voices_mp3 extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_songs_satin_panties_inst_mp3 extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_songs_satin_panties_voices_mp3 extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_songs_senpai_inst_mp3 extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_songs_senpai_voices_mp3 extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_songs_south_inst_mp3 extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_songs_south_voices_mp3 extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_songs_spookeez_inst_mp3 extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_songs_spookeez_voices_mp3 extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_songs_test_inst_mp3 extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_songs_test_voices_mp3 extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_songs_thorns_inst_mp3 extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_songs_thorns_voices_mp3 extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_songs_tutorial_inst_mp3 extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_songs_winter_horrorland_inst_mp3 extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_songs_winter_horrorland_voices_mp3 extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_shared_images_bad_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_shared_images_characters_bfcar_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_shared_images_characters_bfcar_xml extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_shared_images_characters_bfchristmas_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_shared_images_characters_bfchristmas_xml extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_shared_images_characters_bfpixel_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_shared_images_characters_bfpixel_xml extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_shared_images_characters_bfpixelsdead_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_shared_images_characters_bfpixelsdead_xml extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_shared_images_characters_daddy_dearest_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_shared_images_characters_daddy_dearest_xml extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_shared_images_characters_gfcar_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_shared_images_characters_gfcar_xml extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_shared_images_characters_gfchristmas_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_shared_images_characters_gfchristmas_xml extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_shared_images_characters_gfpixel_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_shared_images_characters_gfpixel_xml extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_shared_images_characters_gf_assets_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_shared_images_characters_gf_assets_xml extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_shared_images_characters_momcar_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_shared_images_characters_momcar_xml extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_shared_images_characters_mom_assets_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_shared_images_characters_mom_assets_xml extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_shared_images_characters_mom_dad_christmas_assets_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_shared_images_characters_mom_dad_christmas_assets_xml extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_shared_images_characters_monsterchristmas_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_shared_images_characters_monsterchristmas_xml extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_shared_images_characters_monster_assets_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_shared_images_characters_monster_assets_xml extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_shared_images_characters_pico_fnf_assetss_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_shared_images_characters_pico_fnf_assetss_xml extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_shared_images_characters_senpai_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_shared_images_characters_senpai_xml extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_shared_images_characters_spirit_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_shared_images_characters_spirit_txt extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_shared_images_characters_spooky_kids_assets_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_shared_images_characters_spooky_kids_assets_xml extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_shared_images_combo_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_shared_images_dialogue_bf_dialogue_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_shared_images_dialogue_bf_dialogue_xml extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_shared_images_dialogue_gf_dialogue_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_shared_images_dialogue_gf_dialogue_xml extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_shared_images_eventarrow_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_shared_images_go_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_shared_images_good_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_shared_images_grafix_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_shared_images_healthbar_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_shared_images_hitbox_hitbox_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_shared_images_hitbox_hitbox_xml extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_shared_images_hitbox_hitbox_hint_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_shared_images_images_go_here_txt extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_shared_images_key_shift_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_shared_images_key_space_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_shared_images_pausealt_bflol_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_shared_images_pausealt_bflol_xml extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_shared_images_pausealt_pausebg_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_shared_images_pausealt_pauseui_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_shared_images_pausealt_pauseui_xml extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_shared_images_ready_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_shared_images_set_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_shared_images_shit_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_shared_images_sick_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_shared_images_speech_bubble_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_shared_images_speech_bubble_xml extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_shared_images_stageback_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_shared_images_stagecurtains_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_shared_images_stagefront_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_shared_images_stage_light_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_shared_images_timebar_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_shared_images_weeb_weebschool_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_shared_images_weeb_weebsky_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_shared_images_weeb_weebstreet_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_shared_images_weeb_weebtrees_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_shared_images_weeb_weebtrees_txt extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_shared_music_breakfast_mp3 extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_shared_music_gameover_mp3 extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_shared_music_gameoverend_mp3 extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_shared_sounds_angry_mp3 extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_shared_sounds_angry_text_box_mp3 extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_shared_sounds_badnoise1_mp3 extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_shared_sounds_badnoise2_mp3 extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_shared_sounds_badnoise3_mp3 extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_shared_sounds_chartingtick_mp3 extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_shared_sounds_clicktext_mp3 extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_shared_sounds_dialogue_mp3 extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_shared_sounds_dialogueclose_mp3 extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_shared_sounds_fnf_loss_sfx_mp3 extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_shared_sounds_gf_1_mp3 extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_shared_sounds_gf_2_mp3 extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_shared_sounds_gf_3_mp3 extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_shared_sounds_gf_4_mp3 extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_shared_sounds_intro1_mp3 extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_shared_sounds_intro2_mp3 extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_shared_sounds_intro3_mp3 extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_shared_sounds_introgo_mp3 extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_shared_sounds_metronome_tick_mp3 extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_shared_sounds_missnote1_mp3 extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_shared_sounds_missnote2_mp3 extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_shared_sounds_missnote3_mp3 extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_shared_sounds_sounds_go_here_txt extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_shared_sounds_soundtest_mp3 extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_week2_images_halloween_bg_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_week2_images_halloween_bg_xml extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_week2_images_halloween_bg_low_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_week2_sounds_thunder_1_mp3 extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_week2_sounds_thunder_2_mp3 extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_week2_week2_stuff_here_txt extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_week3_images_philly_behindtrain_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_week3_images_philly_behindtrain2_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_week3_images_philly_city_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_week3_images_philly_street_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_week3_images_philly_train_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_week3_images_philly_win0_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_week3_images_philly_win1_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_week3_images_philly_win2_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_week3_images_philly_win3_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_week3_images_philly_win4_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_week3_sounds_train_passes_mp3 extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_week3_week3_stuff_here_txt extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_week4_images_gore_coldheartkiller_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_week4_images_gore_metalpole_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_week4_images_gore_noooooo_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_week4_images_gore_noooooo_xml extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_week4_images_gore_stupidblood_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_week4_images_gore_stupidblood_xml extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_week4_images_limo_bglimo_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_week4_images_limo_bglimo_xml extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_week4_images_limo_dumb_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_week4_images_limo_fastcarlol_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_week4_images_limo_limodancer_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_week4_images_limo_limodancer_xml extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_week4_images_limo_limodrive_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_week4_images_limo_limodrive_xml extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_week4_images_limo_limosunset_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_week4_sounds_carpass0_mp3 extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_week4_sounds_carpass1_mp3 extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_week4_sounds_dancerdeath_mp3 extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_week4_week4_stuff_here_txt extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_week5_images_christmas_bgescalator_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_week5_images_christmas_bgwalls_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_week5_images_christmas_evilbg_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_week5_images_christmas_evilsnow_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_week5_images_christmas_fgsnow_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_week5_sounds_lights_shut_off_mp3 extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_week5_sounds_lights_turn_on_mp3 extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_week5_week5_stuff_here_txt extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_week6_images_weeb_animatedevilschool_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_week6_images_weeb_animatedevilschool_xml extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_week6_images_weeb_animatedevilschool_low_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_week6_images_weeb_bfportrait_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_week6_images_weeb_bfportrait_xml extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_week6_images_weeb_bgfreaks_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_week6_images_weeb_bgfreaks_xml extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_week6_images_weeb_bgghouls_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_week6_images_weeb_bgghouls_xml extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_week6_images_weeb_evilschoolbg_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_week6_images_weeb_evilschoolfg_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_week6_images_weeb_petals_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_week6_images_weeb_petals_xml extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_week6_images_weeb_pixelui_dialoguebox_evil_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_week6_images_weeb_pixelui_dialoguebox_evil_xml extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_week6_images_weeb_pixelui_dialoguebox_pixel_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_week6_images_weeb_pixelui_dialoguebox_pixel_xml extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_week6_images_weeb_pixelui_dialoguebox_senpaimad_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_week6_images_weeb_pixelui_dialoguebox_senpaimad_xml extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_week6_images_weeb_pixelui_hand_textbox_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_week6_images_weeb_senpaicrazy_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_week6_images_weeb_senpaicrazy_xml extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_week6_images_weeb_senpaiportrait_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_week6_images_weeb_senpaiportrait_xml extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_week6_images_weeb_spiritfaceforward_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_week6_images_weeb_weebtreesback_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_week6_music_gameover_pixel_mp3 extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_week6_music_gameoverend_pixel_mp3 extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_week6_music_lunchbox_mp3 extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_week6_music_lunchboxscary_mp3 extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_week6_sounds_fnf_loss_sfx_pixel_mp3 extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_week6_sounds_pixeltext_mp3 extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_week6_sounds_senpai_dies_mp3 extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_week6_week6_stuff_here_txt extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__do_not_readme_txt extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_fonts_fonts_go_here_txt extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_fonts_pixel_otf extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_fonts_vcr_ttf extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__flixel_sounds_beep_mp3 extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__flixel_sounds_flixel_mp3 extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__flixel_sounds_beep_ogg extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__flixel_sounds_flixel_ogg extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__flixel_fonts_nokiafc22_ttf extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__flixel_fonts_monsterrat_ttf extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__flixel_images_ui_button_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__flixel_images_logo_default_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__flixel_flixel_ui_img_box_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__flixel_flixel_ui_img_button_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__flixel_flixel_ui_img_button_arrow_down_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__flixel_flixel_ui_img_button_arrow_left_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__flixel_flixel_ui_img_button_arrow_right_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__flixel_flixel_ui_img_button_arrow_up_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__flixel_flixel_ui_img_button_thin_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__flixel_flixel_ui_img_button_toggle_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__flixel_flixel_ui_img_check_box_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__flixel_flixel_ui_img_check_mark_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__flixel_flixel_ui_img_chrome_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__flixel_flixel_ui_img_chrome_flat_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__flixel_flixel_ui_img_chrome_inset_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__flixel_flixel_ui_img_chrome_light_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__flixel_flixel_ui_img_dropdown_mark_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__flixel_flixel_ui_img_finger_big_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__flixel_flixel_ui_img_finger_small_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__flixel_flixel_ui_img_hilight_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__flixel_flixel_ui_img_invis_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__flixel_flixel_ui_img_minus_mark_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__flixel_flixel_ui_img_plus_mark_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__flixel_flixel_ui_img_radio_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__flixel_flixel_ui_img_radio_dot_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__flixel_flixel_ui_img_swatch_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__flixel_flixel_ui_img_tab_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__flixel_flixel_ui_img_tab_back_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__flixel_flixel_ui_img_tooltip_arrow_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__flixel_flixel_ui_xml_defaults_xml extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__flixel_flixel_ui_xml_default_loading_screen_xml extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__flixel_flixel_ui_xml_default_popup_xml extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__manifest_videos_json extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__manifest_songs_json extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__manifest_shared_json extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__manifest_week2_json extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__manifest_week3_json extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__manifest_week4_json extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__manifest_week5_json extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__manifest_week6_json extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__manifest_default_json extends null { }


#elseif (desktop || cpp)

@:keep @:file("assets/preload/characters/bf-car.json") @:noCompletion #if display private #end class __ASSET__assets_characters_bf_car_json extends haxe.io.Bytes {}
@:keep @:file("assets/preload/characters/bf-christmas.json") @:noCompletion #if display private #end class __ASSET__assets_characters_bf_christmas_json extends haxe.io.Bytes {}
@:keep @:file("assets/preload/characters/bf-pixel-dead.json") @:noCompletion #if display private #end class __ASSET__assets_characters_bf_pixel_dead_json extends haxe.io.Bytes {}
@:keep @:file("assets/preload/characters/bf-pixel-opponent.json") @:noCompletion #if display private #end class __ASSET__assets_characters_bf_pixel_opponent_json extends haxe.io.Bytes {}
@:keep @:file("assets/preload/characters/bf-pixel.json") @:noCompletion #if display private #end class __ASSET__assets_characters_bf_pixel_json extends haxe.io.Bytes {}
@:keep @:file("assets/preload/characters/bf.json") @:noCompletion #if display private #end class __ASSET__assets_characters_bf_json extends haxe.io.Bytes {}
@:keep @:file("assets/preload/characters/dad.json") @:noCompletion #if display private #end class __ASSET__assets_characters_dad_json extends haxe.io.Bytes {}
@:keep @:file("assets/preload/characters/gf-car.json") @:noCompletion #if display private #end class __ASSET__assets_characters_gf_car_json extends haxe.io.Bytes {}
@:keep @:file("assets/preload/characters/gf-christmas.json") @:noCompletion #if display private #end class __ASSET__assets_characters_gf_christmas_json extends haxe.io.Bytes {}
@:keep @:file("assets/preload/characters/gf-pixel.json") @:noCompletion #if display private #end class __ASSET__assets_characters_gf_pixel_json extends haxe.io.Bytes {}
@:keep @:file("assets/preload/characters/gf.json") @:noCompletion #if display private #end class __ASSET__assets_characters_gf_json extends haxe.io.Bytes {}
@:keep @:file("assets/preload/characters/mom-car.json") @:noCompletion #if display private #end class __ASSET__assets_characters_mom_car_json extends haxe.io.Bytes {}
@:keep @:file("assets/preload/characters/mom.json") @:noCompletion #if display private #end class __ASSET__assets_characters_mom_json extends haxe.io.Bytes {}
@:keep @:file("assets/preload/characters/monster-christmas.json") @:noCompletion #if display private #end class __ASSET__assets_characters_monster_christmas_json extends haxe.io.Bytes {}
@:keep @:file("assets/preload/characters/monster.json") @:noCompletion #if display private #end class __ASSET__assets_characters_monster_json extends haxe.io.Bytes {}
@:keep @:file("assets/preload/characters/parents-christmas.json") @:noCompletion #if display private #end class __ASSET__assets_characters_parents_christmas_json extends haxe.io.Bytes {}
@:keep @:file("assets/preload/characters/pico-player.json") @:noCompletion #if display private #end class __ASSET__assets_characters_pico_player_json extends haxe.io.Bytes {}
@:keep @:file("assets/preload/characters/pico.json") @:noCompletion #if display private #end class __ASSET__assets_characters_pico_json extends haxe.io.Bytes {}
@:keep @:file("assets/preload/characters/senpai-angry.json") @:noCompletion #if display private #end class __ASSET__assets_characters_senpai_angry_json extends haxe.io.Bytes {}
@:keep @:file("assets/preload/characters/senpai.json") @:noCompletion #if display private #end class __ASSET__assets_characters_senpai_json extends haxe.io.Bytes {}
@:keep @:file("assets/preload/characters/spirit.json") @:noCompletion #if display private #end class __ASSET__assets_characters_spirit_json extends haxe.io.Bytes {}
@:keep @:file("assets/preload/characters/spooky.json") @:noCompletion #if display private #end class __ASSET__assets_characters_spooky_json extends haxe.io.Bytes {}
@:keep @:file("assets/preload/data/blammed/blammed-easy.json") @:noCompletion #if display private #end class __ASSET__assets_data_blammed_blammed_easy_json extends haxe.io.Bytes {}
@:keep @:file("assets/preload/data/blammed/blammed-hard.json") @:noCompletion #if display private #end class __ASSET__assets_data_blammed_blammed_hard_json extends haxe.io.Bytes {}
@:keep @:file("assets/preload/data/blammed/blammed.json") @:noCompletion #if display private #end class __ASSET__assets_data_blammed_blammed_json extends haxe.io.Bytes {}
@:keep @:file("assets/preload/data/blammed/events.json") @:noCompletion #if display private #end class __ASSET__assets_data_blammed_events_json extends haxe.io.Bytes {}
@:keep @:file("assets/preload/data/bopeebo/bopeebo-boobs.json") @:noCompletion #if display private #end class __ASSET__assets_data_bopeebo_bopeebo_boobs_json extends haxe.io.Bytes {}
@:keep @:file("assets/preload/data/bopeebo/bopeebo-easy.json") @:noCompletion #if display private #end class __ASSET__assets_data_bopeebo_bopeebo_easy_json extends haxe.io.Bytes {}
@:keep @:file("assets/preload/data/bopeebo/bopeebo-hard.json") @:noCompletion #if display private #end class __ASSET__assets_data_bopeebo_bopeebo_hard_json extends haxe.io.Bytes {}
@:keep @:file("assets/preload/data/bopeebo/bopeebo.json") @:noCompletion #if display private #end class __ASSET__assets_data_bopeebo_bopeebo_json extends haxe.io.Bytes {}
@:keep @:file("assets/preload/data/bopeebo/events.json") @:noCompletion #if display private #end class __ASSET__assets_data_bopeebo_events_json extends haxe.io.Bytes {}
@:keep @:file("assets/preload/data/characterList.txt") @:noCompletion #if display private #end class __ASSET__assets_data_characterlist_txt extends haxe.io.Bytes {}
@:keep @:file("assets/preload/data/cocoa/cocoa-easy.json") @:noCompletion #if display private #end class __ASSET__assets_data_cocoa_cocoa_easy_json extends haxe.io.Bytes {}
@:keep @:file("assets/preload/data/cocoa/cocoa-hard.json") @:noCompletion #if display private #end class __ASSET__assets_data_cocoa_cocoa_hard_json extends haxe.io.Bytes {}
@:keep @:file("assets/preload/data/cocoa/cocoa.json") @:noCompletion #if display private #end class __ASSET__assets_data_cocoa_cocoa_json extends haxe.io.Bytes {}
@:keep @:file("assets/preload/data/cocoa/events.json") @:noCompletion #if display private #end class __ASSET__assets_data_cocoa_events_json extends haxe.io.Bytes {}
@:keep @:file("assets/preload/data/dad-battle/dad-battle-easy.json") @:noCompletion #if display private #end class __ASSET__assets_data_dad_battle_dad_battle_easy_json extends haxe.io.Bytes {}
@:keep @:file("assets/preload/data/dad-battle/dad-battle-hard.json") @:noCompletion #if display private #end class __ASSET__assets_data_dad_battle_dad_battle_hard_json extends haxe.io.Bytes {}
@:keep @:file("assets/preload/data/dad-battle/dad-battle.json") @:noCompletion #if display private #end class __ASSET__assets_data_dad_battle_dad_battle_json extends haxe.io.Bytes {}
@:keep @:file("assets/preload/data/data-goes-here.txt") @:noCompletion #if display private #end class __ASSET__assets_data_data_goes_here_txt extends haxe.io.Bytes {}
@:keep @:file("assets/preload/data/eggnog/eggnog-easy.json") @:noCompletion #if display private #end class __ASSET__assets_data_eggnog_eggnog_easy_json extends haxe.io.Bytes {}
@:keep @:file("assets/preload/data/eggnog/eggnog-hard.json") @:noCompletion #if display private #end class __ASSET__assets_data_eggnog_eggnog_hard_json extends haxe.io.Bytes {}
@:keep @:file("assets/preload/data/eggnog/eggnog.json") @:noCompletion #if display private #end class __ASSET__assets_data_eggnog_eggnog_json extends haxe.io.Bytes {}
@:keep @:file("assets/preload/data/eggnog/events.json") @:noCompletion #if display private #end class __ASSET__assets_data_eggnog_events_json extends haxe.io.Bytes {}
@:keep @:file("assets/preload/data/freeplayColors.txt") @:noCompletion #if display private #end class __ASSET__assets_data_freeplaycolors_txt extends haxe.io.Bytes {}
@:keep @:file("assets/preload/data/fresh/events.json") @:noCompletion #if display private #end class __ASSET__assets_data_fresh_events_json extends haxe.io.Bytes {}
@:keep @:file("assets/preload/data/fresh/fresh-easy.json") @:noCompletion #if display private #end class __ASSET__assets_data_fresh_fresh_easy_json extends haxe.io.Bytes {}
@:keep @:file("assets/preload/data/fresh/fresh-hard.json") @:noCompletion #if display private #end class __ASSET__assets_data_fresh_fresh_hard_json extends haxe.io.Bytes {}
@:keep @:file("assets/preload/data/fresh/fresh.json") @:noCompletion #if display private #end class __ASSET__assets_data_fresh_fresh_json extends haxe.io.Bytes {}
@:keep @:file("assets/preload/data/high/events.json") @:noCompletion #if display private #end class __ASSET__assets_data_high_events_json extends haxe.io.Bytes {}
@:keep @:file("assets/preload/data/high/high-easy.json") @:noCompletion #if display private #end class __ASSET__assets_data_high_high_easy_json extends haxe.io.Bytes {}
@:keep @:file("assets/preload/data/high/high-hard.json") @:noCompletion #if display private #end class __ASSET__assets_data_high_high_hard_json extends haxe.io.Bytes {}
@:keep @:file("assets/preload/data/high/high.json") @:noCompletion #if display private #end class __ASSET__assets_data_high_high_json extends haxe.io.Bytes {}
@:keep @:file("assets/preload/data/introText.txt") @:noCompletion #if display private #end class __ASSET__assets_data_introtext_txt extends haxe.io.Bytes {}
@:keep @:file("assets/preload/data/main-view.xml") @:noCompletion #if display private #end class __ASSET__assets_data_main_view_xml extends haxe.io.Bytes {}
@:keep @:file("assets/preload/data/milf/events.json") @:noCompletion #if display private #end class __ASSET__assets_data_milf_events_json extends haxe.io.Bytes {}
@:keep @:file("assets/preload/data/milf/milf-easy.json") @:noCompletion #if display private #end class __ASSET__assets_data_milf_milf_easy_json extends haxe.io.Bytes {}
@:keep @:file("assets/preload/data/milf/milf-hard.json") @:noCompletion #if display private #end class __ASSET__assets_data_milf_milf_hard_json extends haxe.io.Bytes {}
@:keep @:file("assets/preload/data/milf/milf.json") @:noCompletion #if display private #end class __ASSET__assets_data_milf_milf_json extends haxe.io.Bytes {}
@:keep @:file("assets/preload/data/monster/monster-easy.json") @:noCompletion #if display private #end class __ASSET__assets_data_monster_monster_easy_json extends haxe.io.Bytes {}
@:keep @:file("assets/preload/data/monster/monster-hard.json") @:noCompletion #if display private #end class __ASSET__assets_data_monster_monster_hard_json extends haxe.io.Bytes {}
@:keep @:file("assets/preload/data/monster/monster.json") @:noCompletion #if display private #end class __ASSET__assets_data_monster_monster_json extends haxe.io.Bytes {}
@:keep @:file("assets/preload/data/philly-nice/events.json") @:noCompletion #if display private #end class __ASSET__assets_data_philly_nice_events_json extends haxe.io.Bytes {}
@:keep @:file("assets/preload/data/philly-nice/philly-nice-easy.json") @:noCompletion #if display private #end class __ASSET__assets_data_philly_nice_philly_nice_easy_json extends haxe.io.Bytes {}
@:keep @:file("assets/preload/data/philly-nice/philly-nice-hard.json") @:noCompletion #if display private #end class __ASSET__assets_data_philly_nice_philly_nice_hard_json extends haxe.io.Bytes {}
@:keep @:file("assets/preload/data/philly-nice/philly-nice.json") @:noCompletion #if display private #end class __ASSET__assets_data_philly_nice_philly_nice_json extends haxe.io.Bytes {}
@:keep @:file("assets/preload/data/pico/pico-easy.json") @:noCompletion #if display private #end class __ASSET__assets_data_pico_pico_easy_json extends haxe.io.Bytes {}
@:keep @:file("assets/preload/data/pico/pico-hard.json") @:noCompletion #if display private #end class __ASSET__assets_data_pico_pico_hard_json extends haxe.io.Bytes {}
@:keep @:file("assets/preload/data/pico/pico.json") @:noCompletion #if display private #end class __ASSET__assets_data_pico_pico_json extends haxe.io.Bytes {}
@:keep @:file("assets/preload/data/ridge/ridge.json") @:noCompletion #if display private #end class __ASSET__assets_data_ridge_ridge_json extends haxe.io.Bytes {}
@:keep @:file("assets/preload/data/roses/events.json") @:noCompletion #if display private #end class __ASSET__assets_data_roses_events_json extends haxe.io.Bytes {}
@:keep @:file("assets/preload/data/roses/roses-easy.json") @:noCompletion #if display private #end class __ASSET__assets_data_roses_roses_easy_json extends haxe.io.Bytes {}
@:keep @:file("assets/preload/data/roses/roses-hard.json") @:noCompletion #if display private #end class __ASSET__assets_data_roses_roses_hard_json extends haxe.io.Bytes {}
@:keep @:file("assets/preload/data/roses/roses.json") @:noCompletion #if display private #end class __ASSET__assets_data_roses_roses_json extends haxe.io.Bytes {}
@:keep @:file("assets/preload/data/roses/rosesDialogue.txt") @:noCompletion #if display private #end class __ASSET__assets_data_roses_rosesdialogue_txt extends haxe.io.Bytes {}
@:keep @:file("assets/preload/data/satin-panties/events.json") @:noCompletion #if display private #end class __ASSET__assets_data_satin_panties_events_json extends haxe.io.Bytes {}
@:keep @:file("assets/preload/data/satin-panties/satin-panties-easy.json") @:noCompletion #if display private #end class __ASSET__assets_data_satin_panties_satin_panties_easy_json extends haxe.io.Bytes {}
@:keep @:file("assets/preload/data/satin-panties/satin-panties-hard.json") @:noCompletion #if display private #end class __ASSET__assets_data_satin_panties_satin_panties_hard_json extends haxe.io.Bytes {}
@:keep @:file("assets/preload/data/satin-panties/satin-panties.json") @:noCompletion #if display private #end class __ASSET__assets_data_satin_panties_satin_panties_json extends haxe.io.Bytes {}
@:keep @:file("assets/preload/data/senpai/senpai-easy.json") @:noCompletion #if display private #end class __ASSET__assets_data_senpai_senpai_easy_json extends haxe.io.Bytes {}
@:keep @:file("assets/preload/data/senpai/senpai-hard.json") @:noCompletion #if display private #end class __ASSET__assets_data_senpai_senpai_hard_json extends haxe.io.Bytes {}
@:keep @:file("assets/preload/data/senpai/senpai.json") @:noCompletion #if display private #end class __ASSET__assets_data_senpai_senpai_json extends haxe.io.Bytes {}
@:keep @:file("assets/preload/data/senpai/senpaiDialogue.txt") @:noCompletion #if display private #end class __ASSET__assets_data_senpai_senpaidialogue_txt extends haxe.io.Bytes {}
@:keep @:file("assets/preload/data/smash/smash.json") @:noCompletion #if display private #end class __ASSET__assets_data_smash_smash_json extends haxe.io.Bytes {}
@:keep @:file("assets/preload/data/south/south-easy.json") @:noCompletion #if display private #end class __ASSET__assets_data_south_south_easy_json extends haxe.io.Bytes {}
@:keep @:file("assets/preload/data/south/south-hard.json") @:noCompletion #if display private #end class __ASSET__assets_data_south_south_hard_json extends haxe.io.Bytes {}
@:keep @:file("assets/preload/data/south/south.json") @:noCompletion #if display private #end class __ASSET__assets_data_south_south_json extends haxe.io.Bytes {}
@:keep @:file("assets/preload/data/specialThanks.txt") @:noCompletion #if display private #end class __ASSET__assets_data_specialthanks_txt extends haxe.io.Bytes {}
@:keep @:file("assets/preload/data/spookeez/spookeez-easy.json") @:noCompletion #if display private #end class __ASSET__assets_data_spookeez_spookeez_easy_json extends haxe.io.Bytes {}
@:keep @:file("assets/preload/data/spookeez/spookeez-hard.json") @:noCompletion #if display private #end class __ASSET__assets_data_spookeez_spookeez_hard_json extends haxe.io.Bytes {}
@:keep @:file("assets/preload/data/spookeez/spookeez.json") @:noCompletion #if display private #end class __ASSET__assets_data_spookeez_spookeez_json extends haxe.io.Bytes {}
@:keep @:file("assets/preload/data/stageList.txt") @:noCompletion #if display private #end class __ASSET__assets_data_stagelist_txt extends haxe.io.Bytes {}
@:keep @:file("assets/preload/data/test/test.json") @:noCompletion #if display private #end class __ASSET__assets_data_test_test_json extends haxe.io.Bytes {}
@:keep @:file("assets/preload/data/thorns/events.json") @:noCompletion #if display private #end class __ASSET__assets_data_thorns_events_json extends haxe.io.Bytes {}
@:keep @:file("assets/preload/data/thorns/thorns-easy.json") @:noCompletion #if display private #end class __ASSET__assets_data_thorns_thorns_easy_json extends haxe.io.Bytes {}
@:keep @:file("assets/preload/data/thorns/thorns-hard.json") @:noCompletion #if display private #end class __ASSET__assets_data_thorns_thorns_hard_json extends haxe.io.Bytes {}
@:keep @:file("assets/preload/data/thorns/thorns.json") @:noCompletion #if display private #end class __ASSET__assets_data_thorns_thorns_json extends haxe.io.Bytes {}
@:keep @:file("assets/preload/data/thorns/thornsDialogue.txt") @:noCompletion #if display private #end class __ASSET__assets_data_thorns_thornsdialogue_txt extends haxe.io.Bytes {}
@:keep @:file("assets/preload/data/tutorial/events.json") @:noCompletion #if display private #end class __ASSET__assets_data_tutorial_events_json extends haxe.io.Bytes {}
@:keep @:file("assets/preload/data/tutorial/tutorial-easy.json") @:noCompletion #if display private #end class __ASSET__assets_data_tutorial_tutorial_easy_json extends haxe.io.Bytes {}
@:keep @:file("assets/preload/data/tutorial/tutorial-hard.json") @:noCompletion #if display private #end class __ASSET__assets_data_tutorial_tutorial_hard_json extends haxe.io.Bytes {}
@:keep @:file("assets/preload/data/tutorial/tutorial.json") @:noCompletion #if display private #end class __ASSET__assets_data_tutorial_tutorial_json extends haxe.io.Bytes {}
@:keep @:file("assets/preload/data/winter-horrorland/events.json") @:noCompletion #if display private #end class __ASSET__assets_data_winter_horrorland_events_json extends haxe.io.Bytes {}
@:keep @:file("assets/preload/data/winter-horrorland/winter-horrorland-easy.json") @:noCompletion #if display private #end class __ASSET__assets_data_winter_horrorland_winter_horrorland_easy_json extends haxe.io.Bytes {}
@:keep @:file("assets/preload/data/winter-horrorland/winter-horrorland-hard.json") @:noCompletion #if display private #end class __ASSET__assets_data_winter_horrorland_winter_horrorland_hard_json extends haxe.io.Bytes {}
@:keep @:file("assets/preload/data/winter-horrorland/winter-horrorland.json") @:noCompletion #if display private #end class __ASSET__assets_data_winter_horrorland_winter_horrorland_json extends haxe.io.Bytes {}
@:keep @:image("assets/preload/images/achievementgrid.png") @:noCompletion #if display private #end class __ASSET__assets_images_achievementgrid_png extends lime.graphics.Image {}
@:keep @:image("assets/preload/images/alphabet.png") @:noCompletion #if display private #end class __ASSET__assets_images_alphabet_png extends lime.graphics.Image {}
@:keep @:file("assets/preload/images/alphabet.xml") @:noCompletion #if display private #end class __ASSET__assets_images_alphabet_xml extends haxe.io.Bytes {}
@:keep @:image("assets/preload/images/campaign_menu_UI_assets.png") @:noCompletion #if display private #end class __ASSET__assets_images_campaign_menu_ui_assets_png extends lime.graphics.Image {}
@:keep @:file("assets/preload/images/campaign_menu_UI_assets.xml") @:noCompletion #if display private #end class __ASSET__assets_images_campaign_menu_ui_assets_xml extends haxe.io.Bytes {}
@:keep @:image("assets/preload/images/characters/BOYFRIEND.png") @:noCompletion #if display private #end class __ASSET__assets_images_characters_boyfriend_png extends lime.graphics.Image {}
@:keep @:file("assets/preload/images/characters/BOYFRIEND.xml") @:noCompletion #if display private #end class __ASSET__assets_images_characters_boyfriend_xml extends haxe.io.Bytes {}
@:keep @:image("assets/preload/images/chart_quant.png") @:noCompletion #if display private #end class __ASSET__assets_images_chart_quant_png extends lime.graphics.Image {}
@:keep @:file("assets/preload/images/chart_quant.xml") @:noCompletion #if display private #end class __ASSET__assets_images_chart_quant_xml extends haxe.io.Bytes {}
@:keep @:image("assets/preload/images/checkboxanim.png") @:noCompletion #if display private #end class __ASSET__assets_images_checkboxanim_png extends lime.graphics.Image {}
@:keep @:file("assets/preload/images/checkboxanim.xml") @:noCompletion #if display private #end class __ASSET__assets_images_checkboxanim_xml extends haxe.io.Bytes {}
@:keep @:image("assets/preload/images/credits/bb-panzu.png") @:noCompletion #if display private #end class __ASSET__assets_images_credits_bb_panzu_png extends lime.graphics.Image {}
@:keep @:image("assets/preload/images/credits/discord.png") @:noCompletion #if display private #end class __ASSET__assets_images_credits_discord_png extends lime.graphics.Image {}
@:keep @:image("assets/preload/images/credits/evilsk8r.png") @:noCompletion #if display private #end class __ASSET__assets_images_credits_evilsk8r_png extends lime.graphics.Image {}
@:keep @:image("assets/preload/images/credits/g3yt.png") @:noCompletion #if display private #end class __ASSET__assets_images_credits_g3yt_png extends lime.graphics.Image {}
@:keep @:image("assets/preload/images/credits/gedehari.png") @:noCompletion #if display private #end class __ASSET__assets_images_credits_gedehari_png extends lime.graphics.Image {}
@:keep @:image("assets/preload/images/credits/iflicky.png") @:noCompletion #if display private #end class __ASSET__assets_images_credits_iflicky_png extends lime.graphics.Image {}
@:keep @:image("assets/preload/images/credits/kawaisprite.png") @:noCompletion #if display private #end class __ASSET__assets_images_credits_kawaisprite_png extends lime.graphics.Image {}
@:keep @:image("assets/preload/images/credits/keoiki.png") @:noCompletion #if display private #end class __ASSET__assets_images_credits_keoiki_png extends lime.graphics.Image {}
@:keep @:image("assets/preload/images/credits/majigsaw.png") @:noCompletion #if display private #end class __ASSET__assets_images_credits_majigsaw_png extends lime.graphics.Image {}
@:keep @:image("assets/preload/images/credits/ninjamuffin99.png") @:noCompletion #if display private #end class __ASSET__assets_images_credits_ninjamuffin99_png extends lime.graphics.Image {}
@:keep @:image("assets/preload/images/credits/phantomarcade.png") @:noCompletion #if display private #end class __ASSET__assets_images_credits_phantomarcade_png extends lime.graphics.Image {}
@:keep @:image("assets/preload/images/credits/polybiusproxy.png") @:noCompletion #if display private #end class __ASSET__assets_images_credits_polybiusproxy_png extends lime.graphics.Image {}
@:keep @:image("assets/preload/images/credits/riveroaken.png") @:noCompletion #if display private #end class __ASSET__assets_images_credits_riveroaken_png extends lime.graphics.Image {}
@:keep @:image("assets/preload/images/credits/shadowmario.png") @:noCompletion #if display private #end class __ASSET__assets_images_credits_shadowmario_png extends lime.graphics.Image {}
@:keep @:image("assets/preload/images/credits/shubs.png") @:noCompletion #if display private #end class __ASSET__assets_images_credits_shubs_png extends lime.graphics.Image {}
@:keep @:image("assets/preload/images/credits/unstop4ble.png") @:noCompletion #if display private #end class __ASSET__assets_images_credits_unstop4ble_png extends lime.graphics.Image {}
@:keep @:image("assets/preload/images/cry_about_it.png") @:noCompletion #if display private #end class __ASSET__assets_images_cry_about_it_png extends lime.graphics.Image {}
@:keep @:file("assets/preload/images/dialogue/bf.json") @:noCompletion #if display private #end class __ASSET__assets_images_dialogue_bf_json extends haxe.io.Bytes {}
@:keep @:file("assets/preload/images/dialogue/gf.json") @:noCompletion #if display private #end class __ASSET__assets_images_dialogue_gf_json extends haxe.io.Bytes {}
@:keep @:image("assets/preload/images/funkay.png") @:noCompletion #if display private #end class __ASSET__assets_images_funkay_png extends lime.graphics.Image {}
@:keep @:file("assets/preload/images/gfDanceTitle.json") @:noCompletion #if display private #end class __ASSET__assets_images_gfdancetitle_json extends haxe.io.Bytes {}
@:keep @:image("assets/preload/images/gfDanceTitle.png") @:noCompletion #if display private #end class __ASSET__assets_images_gfdancetitle_png extends lime.graphics.Image {}
@:keep @:file("assets/preload/images/gfDanceTitle.xml") @:noCompletion #if display private #end class __ASSET__assets_images_gfdancetitle_xml extends haxe.io.Bytes {}
@:keep @:image("assets/preload/images/hahadumb.png") @:noCompletion #if display private #end class __ASSET__assets_images_hahadumb_png extends lime.graphics.Image {}
@:keep @:image("assets/preload/images/hugeW.png") @:noCompletion #if display private #end class __ASSET__assets_images_hugew_png extends lime.graphics.Image {}
@:keep @:image("assets/preload/images/HURTnoteSplashes.png") @:noCompletion #if display private #end class __ASSET__assets_images_hurtnotesplashes_png extends lime.graphics.Image {}
@:keep @:file("assets/preload/images/HURTnoteSplashes.xml") @:noCompletion #if display private #end class __ASSET__assets_images_hurtnotesplashes_xml extends haxe.io.Bytes {}
@:keep @:image("assets/preload/images/HURTNOTE_assets.png") @:noCompletion #if display private #end class __ASSET__assets_images_hurtnote_assets_png extends lime.graphics.Image {}
@:keep @:file("assets/preload/images/HURTNOTE_assets.xml") @:noCompletion #if display private #end class __ASSET__assets_images_hurtnote_assets_xml extends haxe.io.Bytes {}
@:keep @:image("assets/preload/images/icons/icon-bf-old.png") @:noCompletion #if display private #end class __ASSET__assets_images_icons_icon_bf_old_png extends lime.graphics.Image {}
@:keep @:image("assets/preload/images/icons/icon-bf-pixel.png") @:noCompletion #if display private #end class __ASSET__assets_images_icons_icon_bf_pixel_png extends lime.graphics.Image {}
@:keep @:image("assets/preload/images/icons/icon-bf.png") @:noCompletion #if display private #end class __ASSET__assets_images_icons_icon_bf_png extends lime.graphics.Image {}
@:keep @:image("assets/preload/images/icons/icon-dad.png") @:noCompletion #if display private #end class __ASSET__assets_images_icons_icon_dad_png extends lime.graphics.Image {}
@:keep @:image("assets/preload/images/icons/icon-face.png") @:noCompletion #if display private #end class __ASSET__assets_images_icons_icon_face_png extends lime.graphics.Image {}
@:keep @:image("assets/preload/images/icons/icon-gf.png") @:noCompletion #if display private #end class __ASSET__assets_images_icons_icon_gf_png extends lime.graphics.Image {}
@:keep @:image("assets/preload/images/icons/icon-mom.png") @:noCompletion #if display private #end class __ASSET__assets_images_icons_icon_mom_png extends lime.graphics.Image {}
@:keep @:image("assets/preload/images/icons/icon-monster.png") @:noCompletion #if display private #end class __ASSET__assets_images_icons_icon_monster_png extends lime.graphics.Image {}
@:keep @:image("assets/preload/images/icons/icon-parents.png") @:noCompletion #if display private #end class __ASSET__assets_images_icons_icon_parents_png extends lime.graphics.Image {}
@:keep @:image("assets/preload/images/icons/icon-pico.png") @:noCompletion #if display private #end class __ASSET__assets_images_icons_icon_pico_png extends lime.graphics.Image {}
@:keep @:image("assets/preload/images/icons/icon-senpai-pixel.png") @:noCompletion #if display private #end class __ASSET__assets_images_icons_icon_senpai_pixel_png extends lime.graphics.Image {}
@:keep @:image("assets/preload/images/icons/icon-spirit-pixel.png") @:noCompletion #if display private #end class __ASSET__assets_images_icons_icon_spirit_pixel_png extends lime.graphics.Image {}
@:keep @:image("assets/preload/images/icons/icon-spooky.png") @:noCompletion #if display private #end class __ASSET__assets_images_icons_icon_spooky_png extends lime.graphics.Image {}
@:keep @:image("assets/preload/images/icons/icon-tankman.png") @:noCompletion #if display private #end class __ASSET__assets_images_icons_icon_tankman_png extends lime.graphics.Image {}
@:keep @:image("assets/preload/images/lockedachievement.png") @:noCompletion #if display private #end class __ASSET__assets_images_lockedachievement_png extends lime.graphics.Image {}
@:keep @:image("assets/preload/images/logo.png") @:noCompletion #if display private #end class __ASSET__assets_images_logo_png extends lime.graphics.Image {}
@:keep @:image("assets/preload/images/logoBumpin.png") @:noCompletion #if display private #end class __ASSET__assets_images_logobumpin_png extends lime.graphics.Image {}
@:keep @:file("assets/preload/images/logoBumpin.xml") @:noCompletion #if display private #end class __ASSET__assets_images_logobumpin_xml extends haxe.io.Bytes {}
@:keep @:image("assets/preload/images/mainmenu/menu_awards.png") @:noCompletion #if display private #end class __ASSET__assets_images_mainmenu_menu_awards_png extends lime.graphics.Image {}
@:keep @:file("assets/preload/images/mainmenu/menu_awards.xml") @:noCompletion #if display private #end class __ASSET__assets_images_mainmenu_menu_awards_xml extends haxe.io.Bytes {}
@:keep @:image("assets/preload/images/mainmenu/menu_credits.png") @:noCompletion #if display private #end class __ASSET__assets_images_mainmenu_menu_credits_png extends lime.graphics.Image {}
@:keep @:file("assets/preload/images/mainmenu/menu_credits.xml") @:noCompletion #if display private #end class __ASSET__assets_images_mainmenu_menu_credits_xml extends haxe.io.Bytes {}
@:keep @:image("assets/preload/images/mainmenu/menu_donate.png") @:noCompletion #if display private #end class __ASSET__assets_images_mainmenu_menu_donate_png extends lime.graphics.Image {}
@:keep @:file("assets/preload/images/mainmenu/menu_donate.xml") @:noCompletion #if display private #end class __ASSET__assets_images_mainmenu_menu_donate_xml extends haxe.io.Bytes {}
@:keep @:image("assets/preload/images/mainmenu/menu_freeplay.png") @:noCompletion #if display private #end class __ASSET__assets_images_mainmenu_menu_freeplay_png extends lime.graphics.Image {}
@:keep @:file("assets/preload/images/mainmenu/menu_freeplay.xml") @:noCompletion #if display private #end class __ASSET__assets_images_mainmenu_menu_freeplay_xml extends haxe.io.Bytes {}
@:keep @:image("assets/preload/images/mainmenu/menu_mods.png") @:noCompletion #if display private #end class __ASSET__assets_images_mainmenu_menu_mods_png extends lime.graphics.Image {}
@:keep @:file("assets/preload/images/mainmenu/menu_mods.xml") @:noCompletion #if display private #end class __ASSET__assets_images_mainmenu_menu_mods_xml extends haxe.io.Bytes {}
@:keep @:image("assets/preload/images/mainmenu/menu_options.png") @:noCompletion #if display private #end class __ASSET__assets_images_mainmenu_menu_options_png extends lime.graphics.Image {}
@:keep @:file("assets/preload/images/mainmenu/menu_options.xml") @:noCompletion #if display private #end class __ASSET__assets_images_mainmenu_menu_options_xml extends haxe.io.Bytes {}
@:keep @:image("assets/preload/images/mainmenu/menu_story_mode.png") @:noCompletion #if display private #end class __ASSET__assets_images_mainmenu_menu_story_mode_png extends lime.graphics.Image {}
@:keep @:file("assets/preload/images/mainmenu/menu_story_mode.xml") @:noCompletion #if display private #end class __ASSET__assets_images_mainmenu_menu_story_mode_xml extends haxe.io.Bytes {}
@:keep @:image("assets/preload/images/menubackgrounds/menu_christmas.png") @:noCompletion #if display private #end class __ASSET__assets_images_menubackgrounds_menu_christmas_png extends lime.graphics.Image {}
@:keep @:image("assets/preload/images/menubackgrounds/menu_halloween.png") @:noCompletion #if display private #end class __ASSET__assets_images_menubackgrounds_menu_halloween_png extends lime.graphics.Image {}
@:keep @:image("assets/preload/images/menubackgrounds/menu_limo.png") @:noCompletion #if display private #end class __ASSET__assets_images_menubackgrounds_menu_limo_png extends lime.graphics.Image {}
@:keep @:image("assets/preload/images/menubackgrounds/menu_philly.png") @:noCompletion #if display private #end class __ASSET__assets_images_menubackgrounds_menu_philly_png extends lime.graphics.Image {}
@:keep @:image("assets/preload/images/menubackgrounds/menu_school.png") @:noCompletion #if display private #end class __ASSET__assets_images_menubackgrounds_menu_school_png extends lime.graphics.Image {}
@:keep @:image("assets/preload/images/menubackgrounds/menu_stage.png") @:noCompletion #if display private #end class __ASSET__assets_images_menubackgrounds_menu_stage_png extends lime.graphics.Image {}
@:keep @:image("assets/preload/images/menuBG.png") @:noCompletion #if display private #end class __ASSET__assets_images_menubg_png extends lime.graphics.Image {}
@:keep @:image("assets/preload/images/menuBGBlue.png") @:noCompletion #if display private #end class __ASSET__assets_images_menubgblue_png extends lime.graphics.Image {}
@:keep @:image("assets/preload/images/menuBGMagenta.png") @:noCompletion #if display private #end class __ASSET__assets_images_menubgmagenta_png extends lime.graphics.Image {}
@:keep @:file("assets/preload/images/menucharacters/bf.json") @:noCompletion #if display private #end class __ASSET__assets_images_menucharacters_bf_json extends haxe.io.Bytes {}
@:keep @:file("assets/preload/images/menucharacters/dad.json") @:noCompletion #if display private #end class __ASSET__assets_images_menucharacters_dad_json extends haxe.io.Bytes {}
@:keep @:file("assets/preload/images/menucharacters/gf.json") @:noCompletion #if display private #end class __ASSET__assets_images_menucharacters_gf_json extends haxe.io.Bytes {}
@:keep @:image("assets/preload/images/menucharacters/Menu_BF.png") @:noCompletion #if display private #end class __ASSET__assets_images_menucharacters_menu_bf_png extends lime.graphics.Image {}
@:keep @:file("assets/preload/images/menucharacters/Menu_BF.xml") @:noCompletion #if display private #end class __ASSET__assets_images_menucharacters_menu_bf_xml extends haxe.io.Bytes {}
@:keep @:image("assets/preload/images/menucharacters/Menu_Dad.png") @:noCompletion #if display private #end class __ASSET__assets_images_menucharacters_menu_dad_png extends lime.graphics.Image {}
@:keep @:file("assets/preload/images/menucharacters/Menu_Dad.xml") @:noCompletion #if display private #end class __ASSET__assets_images_menucharacters_menu_dad_xml extends haxe.io.Bytes {}
@:keep @:image("assets/preload/images/menucharacters/Menu_GF.png") @:noCompletion #if display private #end class __ASSET__assets_images_menucharacters_menu_gf_png extends lime.graphics.Image {}
@:keep @:file("assets/preload/images/menucharacters/Menu_GF.xml") @:noCompletion #if display private #end class __ASSET__assets_images_menucharacters_menu_gf_xml extends haxe.io.Bytes {}
@:keep @:image("assets/preload/images/menucharacters/Menu_Mom.png") @:noCompletion #if display private #end class __ASSET__assets_images_menucharacters_menu_mom_png extends lime.graphics.Image {}
@:keep @:file("assets/preload/images/menucharacters/Menu_Mom.xml") @:noCompletion #if display private #end class __ASSET__assets_images_menucharacters_menu_mom_xml extends haxe.io.Bytes {}
@:keep @:image("assets/preload/images/menucharacters/Menu_Parents.png") @:noCompletion #if display private #end class __ASSET__assets_images_menucharacters_menu_parents_png extends lime.graphics.Image {}
@:keep @:file("assets/preload/images/menucharacters/Menu_Parents.xml") @:noCompletion #if display private #end class __ASSET__assets_images_menucharacters_menu_parents_xml extends haxe.io.Bytes {}
@:keep @:image("assets/preload/images/menucharacters/Menu_Pico.png") @:noCompletion #if display private #end class __ASSET__assets_images_menucharacters_menu_pico_png extends lime.graphics.Image {}
@:keep @:file("assets/preload/images/menucharacters/Menu_Pico.xml") @:noCompletion #if display private #end class __ASSET__assets_images_menucharacters_menu_pico_xml extends haxe.io.Bytes {}
@:keep @:image("assets/preload/images/menucharacters/Menu_Senpai.png") @:noCompletion #if display private #end class __ASSET__assets_images_menucharacters_menu_senpai_png extends lime.graphics.Image {}
@:keep @:file("assets/preload/images/menucharacters/Menu_Senpai.xml") @:noCompletion #if display private #end class __ASSET__assets_images_menucharacters_menu_senpai_xml extends haxe.io.Bytes {}
@:keep @:image("assets/preload/images/menucharacters/Menu_Spooky_Kids.png") @:noCompletion #if display private #end class __ASSET__assets_images_menucharacters_menu_spooky_kids_png extends lime.graphics.Image {}
@:keep @:file("assets/preload/images/menucharacters/Menu_Spooky_Kids.xml") @:noCompletion #if display private #end class __ASSET__assets_images_menucharacters_menu_spooky_kids_xml extends haxe.io.Bytes {}
@:keep @:file("assets/preload/images/menucharacters/mom.json") @:noCompletion #if display private #end class __ASSET__assets_images_menucharacters_mom_json extends haxe.io.Bytes {}
@:keep @:file("assets/preload/images/menucharacters/parents-christmas.json") @:noCompletion #if display private #end class __ASSET__assets_images_menucharacters_parents_christmas_json extends haxe.io.Bytes {}
@:keep @:file("assets/preload/images/menucharacters/pico.json") @:noCompletion #if display private #end class __ASSET__assets_images_menucharacters_pico_json extends haxe.io.Bytes {}
@:keep @:file("assets/preload/images/menucharacters/senpai.json") @:noCompletion #if display private #end class __ASSET__assets_images_menucharacters_senpai_json extends haxe.io.Bytes {}
@:keep @:file("assets/preload/images/menucharacters/spooky.json") @:noCompletion #if display private #end class __ASSET__assets_images_menucharacters_spooky_json extends haxe.io.Bytes {}
@:keep @:image("assets/preload/images/menuDesat.png") @:noCompletion #if display private #end class __ASSET__assets_images_menudesat_png extends lime.graphics.Image {}
@:keep @:image("assets/preload/images/menudifficulties/easy.png") @:noCompletion #if display private #end class __ASSET__assets_images_menudifficulties_easy_png extends lime.graphics.Image {}
@:keep @:image("assets/preload/images/menudifficulties/hard.png") @:noCompletion #if display private #end class __ASSET__assets_images_menudifficulties_hard_png extends lime.graphics.Image {}
@:keep @:image("assets/preload/images/menudifficulties/normal.png") @:noCompletion #if display private #end class __ASSET__assets_images_menudifficulties_normal_png extends lime.graphics.Image {}
@:keep @:image("assets/preload/images/Menu_Tracks.png") @:noCompletion #if display private #end class __ASSET__assets_images_menu_tracks_png extends lime.graphics.Image {}
@:keep @:image("assets/preload/images/newgrounds_logo.png") @:noCompletion #if display private #end class __ASSET__assets_images_newgrounds_logo_png extends lime.graphics.Image {}
@:keep @:image("assets/preload/images/noteSplashes.png") @:noCompletion #if display private #end class __ASSET__assets_images_notesplashes_png extends lime.graphics.Image {}
@:keep @:file("assets/preload/images/noteSplashes.xml") @:noCompletion #if display private #end class __ASSET__assets_images_notesplashes_xml extends haxe.io.Bytes {}
@:keep @:image("assets/preload/images/NOTE_assets.png") @:noCompletion #if display private #end class __ASSET__assets_images_note_assets_png extends lime.graphics.Image {}
@:keep @:file("assets/preload/images/NOTE_assets.xml") @:noCompletion #if display private #end class __ASSET__assets_images_note_assets_xml extends haxe.io.Bytes {}
@:keep @:image("assets/preload/images/num0.png") @:noCompletion #if display private #end class __ASSET__assets_images_num0_png extends lime.graphics.Image {}
@:keep @:image("assets/preload/images/num1.png") @:noCompletion #if display private #end class __ASSET__assets_images_num1_png extends lime.graphics.Image {}
@:keep @:image("assets/preload/images/num2.png") @:noCompletion #if display private #end class __ASSET__assets_images_num2_png extends lime.graphics.Image {}
@:keep @:image("assets/preload/images/num3.png") @:noCompletion #if display private #end class __ASSET__assets_images_num3_png extends lime.graphics.Image {}
@:keep @:image("assets/preload/images/num4.png") @:noCompletion #if display private #end class __ASSET__assets_images_num4_png extends lime.graphics.Image {}
@:keep @:image("assets/preload/images/num5.png") @:noCompletion #if display private #end class __ASSET__assets_images_num5_png extends lime.graphics.Image {}
@:keep @:image("assets/preload/images/num6.png") @:noCompletion #if display private #end class __ASSET__assets_images_num6_png extends lime.graphics.Image {}
@:keep @:image("assets/preload/images/num7.png") @:noCompletion #if display private #end class __ASSET__assets_images_num7_png extends lime.graphics.Image {}
@:keep @:image("assets/preload/images/num8.png") @:noCompletion #if display private #end class __ASSET__assets_images_num8_png extends lime.graphics.Image {}
@:keep @:image("assets/preload/images/num9.png") @:noCompletion #if display private #end class __ASSET__assets_images_num9_png extends lime.graphics.Image {}
@:keep @:image("assets/preload/images/pixelUI/bad-pixel.png") @:noCompletion #if display private #end class __ASSET__assets_images_pixelui_bad_pixel_png extends lime.graphics.Image {}
@:keep @:image("assets/preload/images/pixelUI/combo-pixel.png") @:noCompletion #if display private #end class __ASSET__assets_images_pixelui_combo_pixel_png extends lime.graphics.Image {}
@:keep @:image("assets/preload/images/pixelUI/date-pixel.png") @:noCompletion #if display private #end class __ASSET__assets_images_pixelui_date_pixel_png extends lime.graphics.Image {}
@:keep @:image("assets/preload/images/pixelUI/good-pixel.png") @:noCompletion #if display private #end class __ASSET__assets_images_pixelui_good_pixel_png extends lime.graphics.Image {}
@:keep @:image("assets/preload/images/pixelUI/HURTNOTE_assets.png") @:noCompletion #if display private #end class __ASSET__assets_images_pixelui_hurtnote_assets_png extends lime.graphics.Image {}
@:keep @:image("assets/preload/images/pixelUI/HURTNOTE_assetsENDS.png") @:noCompletion #if display private #end class __ASSET__assets_images_pixelui_hurtnote_assetsends_png extends lime.graphics.Image {}
@:keep @:image("assets/preload/images/pixelUI/NOTE_assets.png") @:noCompletion #if display private #end class __ASSET__assets_images_pixelui_note_assets_png extends lime.graphics.Image {}
@:keep @:image("assets/preload/images/pixelUI/NOTE_assetsENDS.png") @:noCompletion #if display private #end class __ASSET__assets_images_pixelui_note_assetsends_png extends lime.graphics.Image {}
@:keep @:image("assets/preload/images/pixelUI/num0-pixel.png") @:noCompletion #if display private #end class __ASSET__assets_images_pixelui_num0_pixel_png extends lime.graphics.Image {}
@:keep @:image("assets/preload/images/pixelUI/num1-pixel.png") @:noCompletion #if display private #end class __ASSET__assets_images_pixelui_num1_pixel_png extends lime.graphics.Image {}
@:keep @:image("assets/preload/images/pixelUI/num2-pixel.png") @:noCompletion #if display private #end class __ASSET__assets_images_pixelui_num2_pixel_png extends lime.graphics.Image {}
@:keep @:image("assets/preload/images/pixelUI/num3-pixel.png") @:noCompletion #if display private #end class __ASSET__assets_images_pixelui_num3_pixel_png extends lime.graphics.Image {}
@:keep @:image("assets/preload/images/pixelUI/num4-pixel.png") @:noCompletion #if display private #end class __ASSET__assets_images_pixelui_num4_pixel_png extends lime.graphics.Image {}
@:keep @:image("assets/preload/images/pixelUI/num5-pixel.png") @:noCompletion #if display private #end class __ASSET__assets_images_pixelui_num5_pixel_png extends lime.graphics.Image {}
@:keep @:image("assets/preload/images/pixelUI/num6-pixel.png") @:noCompletion #if display private #end class __ASSET__assets_images_pixelui_num6_pixel_png extends lime.graphics.Image {}
@:keep @:image("assets/preload/images/pixelUI/num7-pixel.png") @:noCompletion #if display private #end class __ASSET__assets_images_pixelui_num7_pixel_png extends lime.graphics.Image {}
@:keep @:image("assets/preload/images/pixelUI/num8-pixel.png") @:noCompletion #if display private #end class __ASSET__assets_images_pixelui_num8_pixel_png extends lime.graphics.Image {}
@:keep @:image("assets/preload/images/pixelUI/num9-pixel.png") @:noCompletion #if display private #end class __ASSET__assets_images_pixelui_num9_pixel_png extends lime.graphics.Image {}
@:keep @:image("assets/preload/images/pixelUI/ready-pixel.png") @:noCompletion #if display private #end class __ASSET__assets_images_pixelui_ready_pixel_png extends lime.graphics.Image {}
@:keep @:image("assets/preload/images/pixelUI/set-pixel.png") @:noCompletion #if display private #end class __ASSET__assets_images_pixelui_set_pixel_png extends lime.graphics.Image {}
@:keep @:image("assets/preload/images/pixelUI/shit-pixel.png") @:noCompletion #if display private #end class __ASSET__assets_images_pixelui_shit_pixel_png extends lime.graphics.Image {}
@:keep @:image("assets/preload/images/pixelUI/sick-pixel.png") @:noCompletion #if display private #end class __ASSET__assets_images_pixelui_sick_pixel_png extends lime.graphics.Image {}
@:keep @:image("assets/preload/images/storymenu/tutorial.png") @:noCompletion #if display private #end class __ASSET__assets_images_storymenu_tutorial_png extends lime.graphics.Image {}
@:keep @:image("assets/preload/images/storymenu/week1.png") @:noCompletion #if display private #end class __ASSET__assets_images_storymenu_week1_png extends lime.graphics.Image {}
@:keep @:image("assets/preload/images/storymenu/week2.png") @:noCompletion #if display private #end class __ASSET__assets_images_storymenu_week2_png extends lime.graphics.Image {}
@:keep @:image("assets/preload/images/storymenu/week3.png") @:noCompletion #if display private #end class __ASSET__assets_images_storymenu_week3_png extends lime.graphics.Image {}
@:keep @:image("assets/preload/images/storymenu/week4.png") @:noCompletion #if display private #end class __ASSET__assets_images_storymenu_week4_png extends lime.graphics.Image {}
@:keep @:image("assets/preload/images/storymenu/week5.png") @:noCompletion #if display private #end class __ASSET__assets_images_storymenu_week5_png extends lime.graphics.Image {}
@:keep @:image("assets/preload/images/storymenu/week6.png") @:noCompletion #if display private #end class __ASSET__assets_images_storymenu_week6_png extends lime.graphics.Image {}
@:keep @:image("assets/preload/images/titleEnter.png") @:noCompletion #if display private #end class __ASSET__assets_images_titleenter_png extends lime.graphics.Image {}
@:keep @:file("assets/preload/images/titleEnter.xml") @:noCompletion #if display private #end class __ASSET__assets_images_titleenter_xml extends haxe.io.Bytes {}
@:keep @:image("assets/preload/images/ui/butt_graph0001.png") @:noCompletion #if display private #end class __ASSET__assets_images_ui_butt_graph0001_png extends lime.graphics.Image {}
@:keep @:image("assets/preload/images/ui/butt_graph0002.png") @:noCompletion #if display private #end class __ASSET__assets_images_ui_butt_graph0002_png extends lime.graphics.Image {}
@:keep @:image("assets/preload/images/ui/butt_graph0003.png") @:noCompletion #if display private #end class __ASSET__assets_images_ui_butt_graph0003_png extends lime.graphics.Image {}
@:keep @:image("assets/preload/images/ui/butt_graph0004.png") @:noCompletion #if display private #end class __ASSET__assets_images_ui_butt_graph0004_png extends lime.graphics.Image {}
@:keep @:image("assets/preload/images/ui/butt_graph0005.png") @:noCompletion #if display private #end class __ASSET__assets_images_ui_butt_graph0005_png extends lime.graphics.Image {}
@:keep @:image("assets/preload/images/unknownMod.png") @:noCompletion #if display private #end class __ASSET__assets_images_unknownmod_png extends lime.graphics.Image {}
@:keep @:image("assets/preload/images/virtualpad.png") @:noCompletion #if display private #end class __ASSET__assets_images_virtualpad_png extends lime.graphics.Image {}
@:keep @:file("assets/preload/images/virtualpad.txt") @:noCompletion #if display private #end class __ASSET__assets_images_virtualpad_txt extends haxe.io.Bytes {}
@:keep @:file("assets/preload/music/freakyMenu.mp3") @:noCompletion #if display private #end class __ASSET__assets_music_freakymenu_mp3 extends haxe.io.Bytes {}
@:keep @:file("assets/preload/music/offsetSong.mp3") @:noCompletion #if display private #end class __ASSET__assets_music_offsetsong_mp3 extends haxe.io.Bytes {}
@:keep @:file("assets/preload/sounds/cancelMenu.mp3") @:noCompletion #if display private #end class __ASSET__assets_sounds_cancelmenu_mp3 extends haxe.io.Bytes {}
@:keep @:file("assets/preload/sounds/confirmMenu.mp3") @:noCompletion #if display private #end class __ASSET__assets_sounds_confirmmenu_mp3 extends haxe.io.Bytes {}
@:keep @:file("assets/preload/sounds/intro1-pixel.mp3") @:noCompletion #if display private #end class __ASSET__assets_sounds_intro1_pixel_mp3 extends haxe.io.Bytes {}
@:keep @:file("assets/preload/sounds/intro2-pixel.mp3") @:noCompletion #if display private #end class __ASSET__assets_sounds_intro2_pixel_mp3 extends haxe.io.Bytes {}
@:keep @:file("assets/preload/sounds/intro3-pixel.mp3") @:noCompletion #if display private #end class __ASSET__assets_sounds_intro3_pixel_mp3 extends haxe.io.Bytes {}
@:keep @:file("assets/preload/sounds/introGo-pixel.mp3") @:noCompletion #if display private #end class __ASSET__assets_sounds_introgo_pixel_mp3 extends haxe.io.Bytes {}
@:keep @:file("assets/preload/sounds/scrollMenu.mp3") @:noCompletion #if display private #end class __ASSET__assets_sounds_scrollmenu_mp3 extends haxe.io.Bytes {}
@:keep @:file("assets/preload/sounds/secretSound.mp3") @:noCompletion #if display private #end class __ASSET__assets_sounds_secretsound_mp3 extends haxe.io.Bytes {}
@:keep @:file("assets/preload/stages/limo.json") @:noCompletion #if display private #end class __ASSET__assets_stages_limo_json extends haxe.io.Bytes {}
@:keep @:file("assets/preload/stages/mall.json") @:noCompletion #if display private #end class __ASSET__assets_stages_mall_json extends haxe.io.Bytes {}
@:keep @:file("assets/preload/stages/mallEvil.json") @:noCompletion #if display private #end class __ASSET__assets_stages_mallevil_json extends haxe.io.Bytes {}
@:keep @:file("assets/preload/stages/philly.json") @:noCompletion #if display private #end class __ASSET__assets_stages_philly_json extends haxe.io.Bytes {}
@:keep @:file("assets/preload/stages/school.json") @:noCompletion #if display private #end class __ASSET__assets_stages_school_json extends haxe.io.Bytes {}
@:keep @:file("assets/preload/stages/schoolEvil.json") @:noCompletion #if display private #end class __ASSET__assets_stages_schoolevil_json extends haxe.io.Bytes {}
@:keep @:file("assets/preload/stages/spooky.json") @:noCompletion #if display private #end class __ASSET__assets_stages_spooky_json extends haxe.io.Bytes {}
@:keep @:file("assets/preload/stages/stage.json") @:noCompletion #if display private #end class __ASSET__assets_stages_stage_json extends haxe.io.Bytes {}
@:keep @:file("assets/preload/weeks/tutorial.json") @:noCompletion #if display private #end class __ASSET__assets_weeks_tutorial_json extends haxe.io.Bytes {}
@:keep @:file("assets/preload/weeks/week1.json") @:noCompletion #if display private #end class __ASSET__assets_weeks_week1_json extends haxe.io.Bytes {}
@:keep @:file("assets/preload/weeks/week2.json") @:noCompletion #if display private #end class __ASSET__assets_weeks_week2_json extends haxe.io.Bytes {}
@:keep @:file("assets/preload/weeks/week3.json") @:noCompletion #if display private #end class __ASSET__assets_weeks_week3_json extends haxe.io.Bytes {}
@:keep @:file("assets/preload/weeks/week4.json") @:noCompletion #if display private #end class __ASSET__assets_weeks_week4_json extends haxe.io.Bytes {}
@:keep @:file("assets/preload/weeks/week5.json") @:noCompletion #if display private #end class __ASSET__assets_weeks_week5_json extends haxe.io.Bytes {}
@:keep @:file("assets/preload/weeks/week6.json") @:noCompletion #if display private #end class __ASSET__assets_weeks_week6_json extends haxe.io.Bytes {}
@:keep @:file("assets/preload/weeks/weekList.txt") @:noCompletion #if display private #end class __ASSET__assets_weeks_weeklist_txt extends haxe.io.Bytes {}
@:keep @:image("assets/videos/html-stuff/none.gif") @:noCompletion #if display private #end class __ASSET__assets_videos_html_stuff_none_gif extends lime.graphics.Image {}
@:keep @:file("assets/videos/html-stuff/video.min.js") @:noCompletion #if display private #end class __ASSET__assets_videos_html_stuff_video_min_js extends haxe.io.Bytes {}
@:keep @:file("assets/videos/put-your-videos-here.txt") @:noCompletion #if display private #end class __ASSET__assets_videos_put_your_videos_here_txt extends haxe.io.Bytes {}
@:keep @:file("assets/songs/blammed/Inst.mp3") @:noCompletion #if display private #end class __ASSET__assets_songs_blammed_inst_mp3 extends haxe.io.Bytes {}
@:keep @:file("assets/songs/blammed/Voices.mp3") @:noCompletion #if display private #end class __ASSET__assets_songs_blammed_voices_mp3 extends haxe.io.Bytes {}
@:keep @:file("assets/songs/bopeebo/Inst.mp3") @:noCompletion #if display private #end class __ASSET__assets_songs_bopeebo_inst_mp3 extends haxe.io.Bytes {}
@:keep @:file("assets/songs/bopeebo/Voices.mp3") @:noCompletion #if display private #end class __ASSET__assets_songs_bopeebo_voices_mp3 extends haxe.io.Bytes {}
@:keep @:file("assets/songs/cocoa/Inst.mp3") @:noCompletion #if display private #end class __ASSET__assets_songs_cocoa_inst_mp3 extends haxe.io.Bytes {}
@:keep @:file("assets/songs/cocoa/Voices.mp3") @:noCompletion #if display private #end class __ASSET__assets_songs_cocoa_voices_mp3 extends haxe.io.Bytes {}
@:keep @:file("assets/songs/dad-battle/Inst.mp3") @:noCompletion #if display private #end class __ASSET__assets_songs_dad_battle_inst_mp3 extends haxe.io.Bytes {}
@:keep @:file("assets/songs/dad-battle/Voices.mp3") @:noCompletion #if display private #end class __ASSET__assets_songs_dad_battle_voices_mp3 extends haxe.io.Bytes {}
@:keep @:file("assets/songs/eggnog/Inst.mp3") @:noCompletion #if display private #end class __ASSET__assets_songs_eggnog_inst_mp3 extends haxe.io.Bytes {}
@:keep @:file("assets/songs/eggnog/Voices.mp3") @:noCompletion #if display private #end class __ASSET__assets_songs_eggnog_voices_mp3 extends haxe.io.Bytes {}
@:keep @:file("assets/songs/fresh/Inst.mp3") @:noCompletion #if display private #end class __ASSET__assets_songs_fresh_inst_mp3 extends haxe.io.Bytes {}
@:keep @:file("assets/songs/fresh/Voices.mp3") @:noCompletion #if display private #end class __ASSET__assets_songs_fresh_voices_mp3 extends haxe.io.Bytes {}
@:keep @:file("assets/songs/high/Inst.mp3") @:noCompletion #if display private #end class __ASSET__assets_songs_high_inst_mp3 extends haxe.io.Bytes {}
@:keep @:file("assets/songs/high/Voices.mp3") @:noCompletion #if display private #end class __ASSET__assets_songs_high_voices_mp3 extends haxe.io.Bytes {}
@:keep @:file("assets/songs/milf/Inst.mp3") @:noCompletion #if display private #end class __ASSET__assets_songs_milf_inst_mp3 extends haxe.io.Bytes {}
@:keep @:file("assets/songs/milf/Voices.mp3") @:noCompletion #if display private #end class __ASSET__assets_songs_milf_voices_mp3 extends haxe.io.Bytes {}
@:keep @:file("assets/songs/monster/Inst.mp3") @:noCompletion #if display private #end class __ASSET__assets_songs_monster_inst_mp3 extends haxe.io.Bytes {}
@:keep @:file("assets/songs/monster/Voices.mp3") @:noCompletion #if display private #end class __ASSET__assets_songs_monster_voices_mp3 extends haxe.io.Bytes {}
@:keep @:file("assets/songs/philly-nice/Inst.mp3") @:noCompletion #if display private #end class __ASSET__assets_songs_philly_nice_inst_mp3 extends haxe.io.Bytes {}
@:keep @:file("assets/songs/philly-nice/Voices.mp3") @:noCompletion #if display private #end class __ASSET__assets_songs_philly_nice_voices_mp3 extends haxe.io.Bytes {}
@:keep @:file("assets/songs/pico/Inst.mp3") @:noCompletion #if display private #end class __ASSET__assets_songs_pico_inst_mp3 extends haxe.io.Bytes {}
@:keep @:file("assets/songs/pico/Voices.mp3") @:noCompletion #if display private #end class __ASSET__assets_songs_pico_voices_mp3 extends haxe.io.Bytes {}
@:keep @:file("assets/songs/roses/Inst.mp3") @:noCompletion #if display private #end class __ASSET__assets_songs_roses_inst_mp3 extends haxe.io.Bytes {}
@:keep @:file("assets/songs/roses/Voices.mp3") @:noCompletion #if display private #end class __ASSET__assets_songs_roses_voices_mp3 extends haxe.io.Bytes {}
@:keep @:file("assets/songs/satin-panties/Inst.mp3") @:noCompletion #if display private #end class __ASSET__assets_songs_satin_panties_inst_mp3 extends haxe.io.Bytes {}
@:keep @:file("assets/songs/satin-panties/Voices.mp3") @:noCompletion #if display private #end class __ASSET__assets_songs_satin_panties_voices_mp3 extends haxe.io.Bytes {}
@:keep @:file("assets/songs/senpai/Inst.mp3") @:noCompletion #if display private #end class __ASSET__assets_songs_senpai_inst_mp3 extends haxe.io.Bytes {}
@:keep @:file("assets/songs/senpai/Voices.mp3") @:noCompletion #if display private #end class __ASSET__assets_songs_senpai_voices_mp3 extends haxe.io.Bytes {}
@:keep @:file("assets/songs/south/Inst.mp3") @:noCompletion #if display private #end class __ASSET__assets_songs_south_inst_mp3 extends haxe.io.Bytes {}
@:keep @:file("assets/songs/south/Voices.mp3") @:noCompletion #if display private #end class __ASSET__assets_songs_south_voices_mp3 extends haxe.io.Bytes {}
@:keep @:file("assets/songs/spookeez/Inst.mp3") @:noCompletion #if display private #end class __ASSET__assets_songs_spookeez_inst_mp3 extends haxe.io.Bytes {}
@:keep @:file("assets/songs/spookeez/Voices.mp3") @:noCompletion #if display private #end class __ASSET__assets_songs_spookeez_voices_mp3 extends haxe.io.Bytes {}
@:keep @:file("assets/songs/test/Inst.mp3") @:noCompletion #if display private #end class __ASSET__assets_songs_test_inst_mp3 extends haxe.io.Bytes {}
@:keep @:file("assets/songs/test/Voices.mp3") @:noCompletion #if display private #end class __ASSET__assets_songs_test_voices_mp3 extends haxe.io.Bytes {}
@:keep @:file("assets/songs/thorns/Inst.mp3") @:noCompletion #if display private #end class __ASSET__assets_songs_thorns_inst_mp3 extends haxe.io.Bytes {}
@:keep @:file("assets/songs/thorns/Voices.mp3") @:noCompletion #if display private #end class __ASSET__assets_songs_thorns_voices_mp3 extends haxe.io.Bytes {}
@:keep @:file("assets/songs/tutorial/Inst.mp3") @:noCompletion #if display private #end class __ASSET__assets_songs_tutorial_inst_mp3 extends haxe.io.Bytes {}
@:keep @:file("assets/songs/winter-horrorland/Inst.mp3") @:noCompletion #if display private #end class __ASSET__assets_songs_winter_horrorland_inst_mp3 extends haxe.io.Bytes {}
@:keep @:file("assets/songs/winter-horrorland/Voices.mp3") @:noCompletion #if display private #end class __ASSET__assets_songs_winter_horrorland_voices_mp3 extends haxe.io.Bytes {}
@:keep @:image("assets/shared/images/bad.png") @:noCompletion #if display private #end class __ASSET__assets_shared_images_bad_png extends lime.graphics.Image {}
@:keep @:image("assets/shared/images/characters/bfCar.png") @:noCompletion #if display private #end class __ASSET__assets_shared_images_characters_bfcar_png extends lime.graphics.Image {}
@:keep @:file("assets/shared/images/characters/bfCar.xml") @:noCompletion #if display private #end class __ASSET__assets_shared_images_characters_bfcar_xml extends haxe.io.Bytes {}
@:keep @:image("assets/shared/images/characters/bfChristmas.png") @:noCompletion #if display private #end class __ASSET__assets_shared_images_characters_bfchristmas_png extends lime.graphics.Image {}
@:keep @:file("assets/shared/images/characters/bfChristmas.xml") @:noCompletion #if display private #end class __ASSET__assets_shared_images_characters_bfchristmas_xml extends haxe.io.Bytes {}
@:keep @:image("assets/shared/images/characters/bfPixel.png") @:noCompletion #if display private #end class __ASSET__assets_shared_images_characters_bfpixel_png extends lime.graphics.Image {}
@:keep @:file("assets/shared/images/characters/bfPixel.xml") @:noCompletion #if display private #end class __ASSET__assets_shared_images_characters_bfpixel_xml extends haxe.io.Bytes {}
@:keep @:image("assets/shared/images/characters/bfPixelsDEAD.png") @:noCompletion #if display private #end class __ASSET__assets_shared_images_characters_bfpixelsdead_png extends lime.graphics.Image {}
@:keep @:file("assets/shared/images/characters/bfPixelsDEAD.xml") @:noCompletion #if display private #end class __ASSET__assets_shared_images_characters_bfpixelsdead_xml extends haxe.io.Bytes {}
@:keep @:image("assets/shared/images/characters/DADDY_DEAREST.png") @:noCompletion #if display private #end class __ASSET__assets_shared_images_characters_daddy_dearest_png extends lime.graphics.Image {}
@:keep @:file("assets/shared/images/characters/DADDY_DEAREST.xml") @:noCompletion #if display private #end class __ASSET__assets_shared_images_characters_daddy_dearest_xml extends haxe.io.Bytes {}
@:keep @:image("assets/shared/images/characters/gfCar.png") @:noCompletion #if display private #end class __ASSET__assets_shared_images_characters_gfcar_png extends lime.graphics.Image {}
@:keep @:file("assets/shared/images/characters/gfCar.xml") @:noCompletion #if display private #end class __ASSET__assets_shared_images_characters_gfcar_xml extends haxe.io.Bytes {}
@:keep @:image("assets/shared/images/characters/gfChristmas.png") @:noCompletion #if display private #end class __ASSET__assets_shared_images_characters_gfchristmas_png extends lime.graphics.Image {}
@:keep @:file("assets/shared/images/characters/gfChristmas.xml") @:noCompletion #if display private #end class __ASSET__assets_shared_images_characters_gfchristmas_xml extends haxe.io.Bytes {}
@:keep @:image("assets/shared/images/characters/gfPixel.png") @:noCompletion #if display private #end class __ASSET__assets_shared_images_characters_gfpixel_png extends lime.graphics.Image {}
@:keep @:file("assets/shared/images/characters/gfPixel.xml") @:noCompletion #if display private #end class __ASSET__assets_shared_images_characters_gfpixel_xml extends haxe.io.Bytes {}
@:keep @:image("assets/shared/images/characters/GF_assets.png") @:noCompletion #if display private #end class __ASSET__assets_shared_images_characters_gf_assets_png extends lime.graphics.Image {}
@:keep @:file("assets/shared/images/characters/GF_assets.xml") @:noCompletion #if display private #end class __ASSET__assets_shared_images_characters_gf_assets_xml extends haxe.io.Bytes {}
@:keep @:image("assets/shared/images/characters/momCar.png") @:noCompletion #if display private #end class __ASSET__assets_shared_images_characters_momcar_png extends lime.graphics.Image {}
@:keep @:file("assets/shared/images/characters/momCar.xml") @:noCompletion #if display private #end class __ASSET__assets_shared_images_characters_momcar_xml extends haxe.io.Bytes {}
@:keep @:image("assets/shared/images/characters/Mom_Assets.png") @:noCompletion #if display private #end class __ASSET__assets_shared_images_characters_mom_assets_png extends lime.graphics.Image {}
@:keep @:file("assets/shared/images/characters/Mom_Assets.xml") @:noCompletion #if display private #end class __ASSET__assets_shared_images_characters_mom_assets_xml extends haxe.io.Bytes {}
@:keep @:image("assets/shared/images/characters/mom_dad_christmas_assets.png") @:noCompletion #if display private #end class __ASSET__assets_shared_images_characters_mom_dad_christmas_assets_png extends lime.graphics.Image {}
@:keep @:file("assets/shared/images/characters/mom_dad_christmas_assets.xml") @:noCompletion #if display private #end class __ASSET__assets_shared_images_characters_mom_dad_christmas_assets_xml extends haxe.io.Bytes {}
@:keep @:image("assets/shared/images/characters/monsterChristmas.png") @:noCompletion #if display private #end class __ASSET__assets_shared_images_characters_monsterchristmas_png extends lime.graphics.Image {}
@:keep @:file("assets/shared/images/characters/monsterChristmas.xml") @:noCompletion #if display private #end class __ASSET__assets_shared_images_characters_monsterchristmas_xml extends haxe.io.Bytes {}
@:keep @:image("assets/shared/images/characters/Monster_Assets.png") @:noCompletion #if display private #end class __ASSET__assets_shared_images_characters_monster_assets_png extends lime.graphics.Image {}
@:keep @:file("assets/shared/images/characters/Monster_Assets.xml") @:noCompletion #if display private #end class __ASSET__assets_shared_images_characters_monster_assets_xml extends haxe.io.Bytes {}
@:keep @:image("assets/shared/images/characters/Pico_FNF_assetss.png") @:noCompletion #if display private #end class __ASSET__assets_shared_images_characters_pico_fnf_assetss_png extends lime.graphics.Image {}
@:keep @:file("assets/shared/images/characters/Pico_FNF_assetss.xml") @:noCompletion #if display private #end class __ASSET__assets_shared_images_characters_pico_fnf_assetss_xml extends haxe.io.Bytes {}
@:keep @:image("assets/shared/images/characters/senpai.png") @:noCompletion #if display private #end class __ASSET__assets_shared_images_characters_senpai_png extends lime.graphics.Image {}
@:keep @:file("assets/shared/images/characters/senpai.xml") @:noCompletion #if display private #end class __ASSET__assets_shared_images_characters_senpai_xml extends haxe.io.Bytes {}
@:keep @:image("assets/shared/images/characters/spirit.png") @:noCompletion #if display private #end class __ASSET__assets_shared_images_characters_spirit_png extends lime.graphics.Image {}
@:keep @:file("assets/shared/images/characters/spirit.txt") @:noCompletion #if display private #end class __ASSET__assets_shared_images_characters_spirit_txt extends haxe.io.Bytes {}
@:keep @:image("assets/shared/images/characters/spooky_kids_assets.png") @:noCompletion #if display private #end class __ASSET__assets_shared_images_characters_spooky_kids_assets_png extends lime.graphics.Image {}
@:keep @:file("assets/shared/images/characters/spooky_kids_assets.xml") @:noCompletion #if display private #end class __ASSET__assets_shared_images_characters_spooky_kids_assets_xml extends haxe.io.Bytes {}
@:keep @:image("assets/shared/images/combo.png") @:noCompletion #if display private #end class __ASSET__assets_shared_images_combo_png extends lime.graphics.Image {}
@:keep @:image("assets/shared/images/dialogue/BF_Dialogue.png") @:noCompletion #if display private #end class __ASSET__assets_shared_images_dialogue_bf_dialogue_png extends lime.graphics.Image {}
@:keep @:file("assets/shared/images/dialogue/BF_Dialogue.xml") @:noCompletion #if display private #end class __ASSET__assets_shared_images_dialogue_bf_dialogue_xml extends haxe.io.Bytes {}
@:keep @:image("assets/shared/images/dialogue/GF_Dialogue.png") @:noCompletion #if display private #end class __ASSET__assets_shared_images_dialogue_gf_dialogue_png extends lime.graphics.Image {}
@:keep @:file("assets/shared/images/dialogue/GF_Dialogue.xml") @:noCompletion #if display private #end class __ASSET__assets_shared_images_dialogue_gf_dialogue_xml extends haxe.io.Bytes {}
@:keep @:image("assets/shared/images/eventArrow.png") @:noCompletion #if display private #end class __ASSET__assets_shared_images_eventarrow_png extends lime.graphics.Image {}
@:keep @:image("assets/shared/images/go.png") @:noCompletion #if display private #end class __ASSET__assets_shared_images_go_png extends lime.graphics.Image {}
@:keep @:image("assets/shared/images/good.png") @:noCompletion #if display private #end class __ASSET__assets_shared_images_good_png extends lime.graphics.Image {}
@:keep @:image("assets/shared/images/grafix.png") @:noCompletion #if display private #end class __ASSET__assets_shared_images_grafix_png extends lime.graphics.Image {}
@:keep @:image("assets/shared/images/healthBar.png") @:noCompletion #if display private #end class __ASSET__assets_shared_images_healthbar_png extends lime.graphics.Image {}
@:keep @:image("assets/shared/images/hitbox/hitbox.png") @:noCompletion #if display private #end class __ASSET__assets_shared_images_hitbox_hitbox_png extends lime.graphics.Image {}
@:keep @:file("assets/shared/images/hitbox/hitbox.xml") @:noCompletion #if display private #end class __ASSET__assets_shared_images_hitbox_hitbox_xml extends haxe.io.Bytes {}
@:keep @:image("assets/shared/images/hitbox/hitbox_hint.png") @:noCompletion #if display private #end class __ASSET__assets_shared_images_hitbox_hitbox_hint_png extends lime.graphics.Image {}
@:keep @:file("assets/shared/images/images-go-here.txt") @:noCompletion #if display private #end class __ASSET__assets_shared_images_images_go_here_txt extends haxe.io.Bytes {}
@:keep @:image("assets/shared/images/key_shift.png") @:noCompletion #if display private #end class __ASSET__assets_shared_images_key_shift_png extends lime.graphics.Image {}
@:keep @:image("assets/shared/images/key_space.png") @:noCompletion #if display private #end class __ASSET__assets_shared_images_key_space_png extends lime.graphics.Image {}
@:keep @:image("assets/shared/images/pauseAlt/bfLol.png") @:noCompletion #if display private #end class __ASSET__assets_shared_images_pausealt_bflol_png extends lime.graphics.Image {}
@:keep @:file("assets/shared/images/pauseAlt/bfLol.xml") @:noCompletion #if display private #end class __ASSET__assets_shared_images_pausealt_bflol_xml extends haxe.io.Bytes {}
@:keep @:image("assets/shared/images/pauseAlt/pauseBG.png") @:noCompletion #if display private #end class __ASSET__assets_shared_images_pausealt_pausebg_png extends lime.graphics.Image {}
@:keep @:image("assets/shared/images/pauseAlt/pauseUI.png") @:noCompletion #if display private #end class __ASSET__assets_shared_images_pausealt_pauseui_png extends lime.graphics.Image {}
@:keep @:file("assets/shared/images/pauseAlt/pauseUI.xml") @:noCompletion #if display private #end class __ASSET__assets_shared_images_pausealt_pauseui_xml extends haxe.io.Bytes {}
@:keep @:image("assets/shared/images/ready.png") @:noCompletion #if display private #end class __ASSET__assets_shared_images_ready_png extends lime.graphics.Image {}
@:keep @:image("assets/shared/images/set.png") @:noCompletion #if display private #end class __ASSET__assets_shared_images_set_png extends lime.graphics.Image {}
@:keep @:image("assets/shared/images/shit.png") @:noCompletion #if display private #end class __ASSET__assets_shared_images_shit_png extends lime.graphics.Image {}
@:keep @:image("assets/shared/images/sick.png") @:noCompletion #if display private #end class __ASSET__assets_shared_images_sick_png extends lime.graphics.Image {}
@:keep @:image("assets/shared/images/speech_bubble.png") @:noCompletion #if display private #end class __ASSET__assets_shared_images_speech_bubble_png extends lime.graphics.Image {}
@:keep @:file("assets/shared/images/speech_bubble.xml") @:noCompletion #if display private #end class __ASSET__assets_shared_images_speech_bubble_xml extends haxe.io.Bytes {}
@:keep @:image("assets/shared/images/stageback.png") @:noCompletion #if display private #end class __ASSET__assets_shared_images_stageback_png extends lime.graphics.Image {}
@:keep @:image("assets/shared/images/stagecurtains.png") @:noCompletion #if display private #end class __ASSET__assets_shared_images_stagecurtains_png extends lime.graphics.Image {}
@:keep @:image("assets/shared/images/stagefront.png") @:noCompletion #if display private #end class __ASSET__assets_shared_images_stagefront_png extends lime.graphics.Image {}
@:keep @:image("assets/shared/images/stage_light.png") @:noCompletion #if display private #end class __ASSET__assets_shared_images_stage_light_png extends lime.graphics.Image {}
@:keep @:image("assets/shared/images/timeBar.png") @:noCompletion #if display private #end class __ASSET__assets_shared_images_timebar_png extends lime.graphics.Image {}
@:keep @:image("assets/shared/images/weeb/weebSchool.png") @:noCompletion #if display private #end class __ASSET__assets_shared_images_weeb_weebschool_png extends lime.graphics.Image {}
@:keep @:image("assets/shared/images/weeb/weebSky.png") @:noCompletion #if display private #end class __ASSET__assets_shared_images_weeb_weebsky_png extends lime.graphics.Image {}
@:keep @:image("assets/shared/images/weeb/weebStreet.png") @:noCompletion #if display private #end class __ASSET__assets_shared_images_weeb_weebstreet_png extends lime.graphics.Image {}
@:keep @:image("assets/shared/images/weeb/weebTrees.png") @:noCompletion #if display private #end class __ASSET__assets_shared_images_weeb_weebtrees_png extends lime.graphics.Image {}
@:keep @:file("assets/shared/images/weeb/weebTrees.txt") @:noCompletion #if display private #end class __ASSET__assets_shared_images_weeb_weebtrees_txt extends haxe.io.Bytes {}
@:keep @:file("assets/shared/music/breakfast.mp3") @:noCompletion #if display private #end class __ASSET__assets_shared_music_breakfast_mp3 extends haxe.io.Bytes {}
@:keep @:file("assets/shared/music/gameOver.mp3") @:noCompletion #if display private #end class __ASSET__assets_shared_music_gameover_mp3 extends haxe.io.Bytes {}
@:keep @:file("assets/shared/music/gameOverEnd.mp3") @:noCompletion #if display private #end class __ASSET__assets_shared_music_gameoverend_mp3 extends haxe.io.Bytes {}
@:keep @:file("assets/shared/sounds/ANGRY.mp3") @:noCompletion #if display private #end class __ASSET__assets_shared_sounds_angry_mp3 extends haxe.io.Bytes {}
@:keep @:file("assets/shared/sounds/ANGRY_TEXT_BOX.mp3") @:noCompletion #if display private #end class __ASSET__assets_shared_sounds_angry_text_box_mp3 extends haxe.io.Bytes {}
@:keep @:file("assets/shared/sounds/badnoise1.mp3") @:noCompletion #if display private #end class __ASSET__assets_shared_sounds_badnoise1_mp3 extends haxe.io.Bytes {}
@:keep @:file("assets/shared/sounds/badnoise2.mp3") @:noCompletion #if display private #end class __ASSET__assets_shared_sounds_badnoise2_mp3 extends haxe.io.Bytes {}
@:keep @:file("assets/shared/sounds/badnoise3.mp3") @:noCompletion #if display private #end class __ASSET__assets_shared_sounds_badnoise3_mp3 extends haxe.io.Bytes {}
@:keep @:file("assets/shared/sounds/ChartingTick.mp3") @:noCompletion #if display private #end class __ASSET__assets_shared_sounds_chartingtick_mp3 extends haxe.io.Bytes {}
@:keep @:file("assets/shared/sounds/clickText.mp3") @:noCompletion #if display private #end class __ASSET__assets_shared_sounds_clicktext_mp3 extends haxe.io.Bytes {}
@:keep @:file("assets/shared/sounds/dialogue.mp3") @:noCompletion #if display private #end class __ASSET__assets_shared_sounds_dialogue_mp3 extends haxe.io.Bytes {}
@:keep @:file("assets/shared/sounds/dialogueClose.mp3") @:noCompletion #if display private #end class __ASSET__assets_shared_sounds_dialogueclose_mp3 extends haxe.io.Bytes {}
@:keep @:file("assets/shared/sounds/fnf_loss_sfx.mp3") @:noCompletion #if display private #end class __ASSET__assets_shared_sounds_fnf_loss_sfx_mp3 extends haxe.io.Bytes {}
@:keep @:file("assets/shared/sounds/GF_1.mp3") @:noCompletion #if display private #end class __ASSET__assets_shared_sounds_gf_1_mp3 extends haxe.io.Bytes {}
@:keep @:file("assets/shared/sounds/GF_2.mp3") @:noCompletion #if display private #end class __ASSET__assets_shared_sounds_gf_2_mp3 extends haxe.io.Bytes {}
@:keep @:file("assets/shared/sounds/GF_3.mp3") @:noCompletion #if display private #end class __ASSET__assets_shared_sounds_gf_3_mp3 extends haxe.io.Bytes {}
@:keep @:file("assets/shared/sounds/GF_4.mp3") @:noCompletion #if display private #end class __ASSET__assets_shared_sounds_gf_4_mp3 extends haxe.io.Bytes {}
@:keep @:file("assets/shared/sounds/intro1.mp3") @:noCompletion #if display private #end class __ASSET__assets_shared_sounds_intro1_mp3 extends haxe.io.Bytes {}
@:keep @:file("assets/shared/sounds/intro2.mp3") @:noCompletion #if display private #end class __ASSET__assets_shared_sounds_intro2_mp3 extends haxe.io.Bytes {}
@:keep @:file("assets/shared/sounds/intro3.mp3") @:noCompletion #if display private #end class __ASSET__assets_shared_sounds_intro3_mp3 extends haxe.io.Bytes {}
@:keep @:file("assets/shared/sounds/introGo.mp3") @:noCompletion #if display private #end class __ASSET__assets_shared_sounds_introgo_mp3 extends haxe.io.Bytes {}
@:keep @:file("assets/shared/sounds/Metronome_Tick.mp3") @:noCompletion #if display private #end class __ASSET__assets_shared_sounds_metronome_tick_mp3 extends haxe.io.Bytes {}
@:keep @:file("assets/shared/sounds/missnote1.mp3") @:noCompletion #if display private #end class __ASSET__assets_shared_sounds_missnote1_mp3 extends haxe.io.Bytes {}
@:keep @:file("assets/shared/sounds/missnote2.mp3") @:noCompletion #if display private #end class __ASSET__assets_shared_sounds_missnote2_mp3 extends haxe.io.Bytes {}
@:keep @:file("assets/shared/sounds/missnote3.mp3") @:noCompletion #if display private #end class __ASSET__assets_shared_sounds_missnote3_mp3 extends haxe.io.Bytes {}
@:keep @:file("assets/shared/sounds/sounds-go-here.txt") @:noCompletion #if display private #end class __ASSET__assets_shared_sounds_sounds_go_here_txt extends haxe.io.Bytes {}
@:keep @:file("assets/shared/sounds/soundTest.mp3") @:noCompletion #if display private #end class __ASSET__assets_shared_sounds_soundtest_mp3 extends haxe.io.Bytes {}
@:keep @:image("assets/week2/images/halloween_bg.png") @:noCompletion #if display private #end class __ASSET__assets_week2_images_halloween_bg_png extends lime.graphics.Image {}
@:keep @:file("assets/week2/images/halloween_bg.xml") @:noCompletion #if display private #end class __ASSET__assets_week2_images_halloween_bg_xml extends haxe.io.Bytes {}
@:keep @:image("assets/week2/images/halloween_bg_low.png") @:noCompletion #if display private #end class __ASSET__assets_week2_images_halloween_bg_low_png extends lime.graphics.Image {}
@:keep @:file("assets/week2/sounds/thunder_1.mp3") @:noCompletion #if display private #end class __ASSET__assets_week2_sounds_thunder_1_mp3 extends haxe.io.Bytes {}
@:keep @:file("assets/week2/sounds/thunder_2.mp3") @:noCompletion #if display private #end class __ASSET__assets_week2_sounds_thunder_2_mp3 extends haxe.io.Bytes {}
@:keep @:file("assets/week2/week2_stuff_here.txt") @:noCompletion #if display private #end class __ASSET__assets_week2_week2_stuff_here_txt extends haxe.io.Bytes {}
@:keep @:image("assets/week3/images/philly/behindTrain.png") @:noCompletion #if display private #end class __ASSET__assets_week3_images_philly_behindtrain_png extends lime.graphics.Image {}
@:keep @:image("assets/week3/images/philly/behindTrain2.png") @:noCompletion #if display private #end class __ASSET__assets_week3_images_philly_behindtrain2_png extends lime.graphics.Image {}
@:keep @:image("assets/week3/images/philly/city.png") @:noCompletion #if display private #end class __ASSET__assets_week3_images_philly_city_png extends lime.graphics.Image {}
@:keep @:image("assets/week3/images/philly/street.png") @:noCompletion #if display private #end class __ASSET__assets_week3_images_philly_street_png extends lime.graphics.Image {}
@:keep @:image("assets/week3/images/philly/train.png") @:noCompletion #if display private #end class __ASSET__assets_week3_images_philly_train_png extends lime.graphics.Image {}
@:keep @:image("assets/week3/images/philly/win0.png") @:noCompletion #if display private #end class __ASSET__assets_week3_images_philly_win0_png extends lime.graphics.Image {}
@:keep @:image("assets/week3/images/philly/win1.png") @:noCompletion #if display private #end class __ASSET__assets_week3_images_philly_win1_png extends lime.graphics.Image {}
@:keep @:image("assets/week3/images/philly/win2.png") @:noCompletion #if display private #end class __ASSET__assets_week3_images_philly_win2_png extends lime.graphics.Image {}
@:keep @:image("assets/week3/images/philly/win3.png") @:noCompletion #if display private #end class __ASSET__assets_week3_images_philly_win3_png extends lime.graphics.Image {}
@:keep @:image("assets/week3/images/philly/win4.png") @:noCompletion #if display private #end class __ASSET__assets_week3_images_philly_win4_png extends lime.graphics.Image {}
@:keep @:file("assets/week3/sounds/train_passes.mp3") @:noCompletion #if display private #end class __ASSET__assets_week3_sounds_train_passes_mp3 extends haxe.io.Bytes {}
@:keep @:file("assets/week3/week3_stuff_here.txt") @:noCompletion #if display private #end class __ASSET__assets_week3_week3_stuff_here_txt extends haxe.io.Bytes {}
@:keep @:image("assets/week4/images/gore/coldHeartKiller.png") @:noCompletion #if display private #end class __ASSET__assets_week4_images_gore_coldheartkiller_png extends lime.graphics.Image {}
@:keep @:image("assets/week4/images/gore/metalPole.png") @:noCompletion #if display private #end class __ASSET__assets_week4_images_gore_metalpole_png extends lime.graphics.Image {}
@:keep @:image("assets/week4/images/gore/noooooo.png") @:noCompletion #if display private #end class __ASSET__assets_week4_images_gore_noooooo_png extends lime.graphics.Image {}
@:keep @:file("assets/week4/images/gore/noooooo.xml") @:noCompletion #if display private #end class __ASSET__assets_week4_images_gore_noooooo_xml extends haxe.io.Bytes {}
@:keep @:image("assets/week4/images/gore/stupidBlood.png") @:noCompletion #if display private #end class __ASSET__assets_week4_images_gore_stupidblood_png extends lime.graphics.Image {}
@:keep @:file("assets/week4/images/gore/stupidBlood.xml") @:noCompletion #if display private #end class __ASSET__assets_week4_images_gore_stupidblood_xml extends haxe.io.Bytes {}
@:keep @:image("assets/week4/images/limo/bgLimo.png") @:noCompletion #if display private #end class __ASSET__assets_week4_images_limo_bglimo_png extends lime.graphics.Image {}
@:keep @:file("assets/week4/images/limo/bgLimo.xml") @:noCompletion #if display private #end class __ASSET__assets_week4_images_limo_bglimo_xml extends haxe.io.Bytes {}
@:keep @:image("assets/week4/images/limo/dumb.png") @:noCompletion #if display private #end class __ASSET__assets_week4_images_limo_dumb_png extends lime.graphics.Image {}
@:keep @:image("assets/week4/images/limo/fastCarLol.png") @:noCompletion #if display private #end class __ASSET__assets_week4_images_limo_fastcarlol_png extends lime.graphics.Image {}
@:keep @:image("assets/week4/images/limo/limoDancer.png") @:noCompletion #if display private #end class __ASSET__assets_week4_images_limo_limodancer_png extends lime.graphics.Image {}
@:keep @:file("assets/week4/images/limo/limoDancer.xml") @:noCompletion #if display private #end class __ASSET__assets_week4_images_limo_limodancer_xml extends haxe.io.Bytes {}
@:keep @:image("assets/week4/images/limo/limoDrive.png") @:noCompletion #if display private #end class __ASSET__assets_week4_images_limo_limodrive_png extends lime.graphics.Image {}
@:keep @:file("assets/week4/images/limo/limoDrive.xml") @:noCompletion #if display private #end class __ASSET__assets_week4_images_limo_limodrive_xml extends haxe.io.Bytes {}
@:keep @:image("assets/week4/images/limo/limoSunset.png") @:noCompletion #if display private #end class __ASSET__assets_week4_images_limo_limosunset_png extends lime.graphics.Image {}
@:keep @:file("assets/week4/sounds/carPass0.mp3") @:noCompletion #if display private #end class __ASSET__assets_week4_sounds_carpass0_mp3 extends haxe.io.Bytes {}
@:keep @:file("assets/week4/sounds/carPass1.mp3") @:noCompletion #if display private #end class __ASSET__assets_week4_sounds_carpass1_mp3 extends haxe.io.Bytes {}
@:keep @:file("assets/week4/sounds/dancerdeath.mp3") @:noCompletion #if display private #end class __ASSET__assets_week4_sounds_dancerdeath_mp3 extends haxe.io.Bytes {}
@:keep @:file("assets/week4/week4_stuff_here.txt") @:noCompletion #if display private #end class __ASSET__assets_week4_week4_stuff_here_txt extends haxe.io.Bytes {}
@:keep @:image("assets/week5/images/christmas/bgEscalator.png") @:noCompletion #if display private #end class __ASSET__assets_week5_images_christmas_bgescalator_png extends lime.graphics.Image {}
@:keep @:image("assets/week5/images/christmas/bgWalls.png") @:noCompletion #if display private #end class __ASSET__assets_week5_images_christmas_bgwalls_png extends lime.graphics.Image {}
@:keep @:image("assets/week5/images/christmas/evilBG.png") @:noCompletion #if display private #end class __ASSET__assets_week5_images_christmas_evilbg_png extends lime.graphics.Image {}
@:keep @:image("assets/week5/images/christmas/evilSnow.png") @:noCompletion #if display private #end class __ASSET__assets_week5_images_christmas_evilsnow_png extends lime.graphics.Image {}
@:keep @:image("assets/week5/images/christmas/fgSnow.png") @:noCompletion #if display private #end class __ASSET__assets_week5_images_christmas_fgsnow_png extends lime.graphics.Image {}
@:keep @:file("assets/week5/sounds/Lights_Shut_off.mp3") @:noCompletion #if display private #end class __ASSET__assets_week5_sounds_lights_shut_off_mp3 extends haxe.io.Bytes {}
@:keep @:file("assets/week5/sounds/Lights_Turn_On.mp3") @:noCompletion #if display private #end class __ASSET__assets_week5_sounds_lights_turn_on_mp3 extends haxe.io.Bytes {}
@:keep @:file("assets/week5/week5_stuff_here.txt") @:noCompletion #if display private #end class __ASSET__assets_week5_week5_stuff_here_txt extends haxe.io.Bytes {}
@:keep @:image("assets/week6/images/weeb/animatedEvilSchool.png") @:noCompletion #if display private #end class __ASSET__assets_week6_images_weeb_animatedevilschool_png extends lime.graphics.Image {}
@:keep @:file("assets/week6/images/weeb/animatedEvilSchool.xml") @:noCompletion #if display private #end class __ASSET__assets_week6_images_weeb_animatedevilschool_xml extends haxe.io.Bytes {}
@:keep @:image("assets/week6/images/weeb/animatedEvilSchool_low.png") @:noCompletion #if display private #end class __ASSET__assets_week6_images_weeb_animatedevilschool_low_png extends lime.graphics.Image {}
@:keep @:image("assets/week6/images/weeb/bfPortrait.png") @:noCompletion #if display private #end class __ASSET__assets_week6_images_weeb_bfportrait_png extends lime.graphics.Image {}
@:keep @:file("assets/week6/images/weeb/bfPortrait.xml") @:noCompletion #if display private #end class __ASSET__assets_week6_images_weeb_bfportrait_xml extends haxe.io.Bytes {}
@:keep @:image("assets/week6/images/weeb/bgFreaks.png") @:noCompletion #if display private #end class __ASSET__assets_week6_images_weeb_bgfreaks_png extends lime.graphics.Image {}
@:keep @:file("assets/week6/images/weeb/bgFreaks.xml") @:noCompletion #if display private #end class __ASSET__assets_week6_images_weeb_bgfreaks_xml extends haxe.io.Bytes {}
@:keep @:image("assets/week6/images/weeb/bgGhouls.png") @:noCompletion #if display private #end class __ASSET__assets_week6_images_weeb_bgghouls_png extends lime.graphics.Image {}
@:keep @:file("assets/week6/images/weeb/bgGhouls.xml") @:noCompletion #if display private #end class __ASSET__assets_week6_images_weeb_bgghouls_xml extends haxe.io.Bytes {}
@:keep @:image("assets/week6/images/weeb/evilSchoolBG.png") @:noCompletion #if display private #end class __ASSET__assets_week6_images_weeb_evilschoolbg_png extends lime.graphics.Image {}
@:keep @:image("assets/week6/images/weeb/evilSchoolFG.png") @:noCompletion #if display private #end class __ASSET__assets_week6_images_weeb_evilschoolfg_png extends lime.graphics.Image {}
@:keep @:image("assets/week6/images/weeb/petals.png") @:noCompletion #if display private #end class __ASSET__assets_week6_images_weeb_petals_png extends lime.graphics.Image {}
@:keep @:file("assets/week6/images/weeb/petals.xml") @:noCompletion #if display private #end class __ASSET__assets_week6_images_weeb_petals_xml extends haxe.io.Bytes {}
@:keep @:image("assets/week6/images/weeb/pixelUI/dialogueBox-evil.png") @:noCompletion #if display private #end class __ASSET__assets_week6_images_weeb_pixelui_dialoguebox_evil_png extends lime.graphics.Image {}
@:keep @:file("assets/week6/images/weeb/pixelUI/dialogueBox-evil.xml") @:noCompletion #if display private #end class __ASSET__assets_week6_images_weeb_pixelui_dialoguebox_evil_xml extends haxe.io.Bytes {}
@:keep @:image("assets/week6/images/weeb/pixelUI/dialogueBox-pixel.png") @:noCompletion #if display private #end class __ASSET__assets_week6_images_weeb_pixelui_dialoguebox_pixel_png extends lime.graphics.Image {}
@:keep @:file("assets/week6/images/weeb/pixelUI/dialogueBox-pixel.xml") @:noCompletion #if display private #end class __ASSET__assets_week6_images_weeb_pixelui_dialoguebox_pixel_xml extends haxe.io.Bytes {}
@:keep @:image("assets/week6/images/weeb/pixelUI/dialogueBox-senpaiMad.png") @:noCompletion #if display private #end class __ASSET__assets_week6_images_weeb_pixelui_dialoguebox_senpaimad_png extends lime.graphics.Image {}
@:keep @:file("assets/week6/images/weeb/pixelUI/dialogueBox-senpaiMad.xml") @:noCompletion #if display private #end class __ASSET__assets_week6_images_weeb_pixelui_dialoguebox_senpaimad_xml extends haxe.io.Bytes {}
@:keep @:image("assets/week6/images/weeb/pixelUI/hand_textbox.png") @:noCompletion #if display private #end class __ASSET__assets_week6_images_weeb_pixelui_hand_textbox_png extends lime.graphics.Image {}
@:keep @:image("assets/week6/images/weeb/senpaiCrazy.png") @:noCompletion #if display private #end class __ASSET__assets_week6_images_weeb_senpaicrazy_png extends lime.graphics.Image {}
@:keep @:file("assets/week6/images/weeb/senpaiCrazy.xml") @:noCompletion #if display private #end class __ASSET__assets_week6_images_weeb_senpaicrazy_xml extends haxe.io.Bytes {}
@:keep @:image("assets/week6/images/weeb/senpaiPortrait.png") @:noCompletion #if display private #end class __ASSET__assets_week6_images_weeb_senpaiportrait_png extends lime.graphics.Image {}
@:keep @:file("assets/week6/images/weeb/senpaiPortrait.xml") @:noCompletion #if display private #end class __ASSET__assets_week6_images_weeb_senpaiportrait_xml extends haxe.io.Bytes {}
@:keep @:image("assets/week6/images/weeb/spiritFaceForward.png") @:noCompletion #if display private #end class __ASSET__assets_week6_images_weeb_spiritfaceforward_png extends lime.graphics.Image {}
@:keep @:image("assets/week6/images/weeb/weebTreesBack.png") @:noCompletion #if display private #end class __ASSET__assets_week6_images_weeb_weebtreesback_png extends lime.graphics.Image {}
@:keep @:file("assets/week6/music/gameOver-pixel.mp3") @:noCompletion #if display private #end class __ASSET__assets_week6_music_gameover_pixel_mp3 extends haxe.io.Bytes {}
@:keep @:file("assets/week6/music/gameOverEnd-pixel.mp3") @:noCompletion #if display private #end class __ASSET__assets_week6_music_gameoverend_pixel_mp3 extends haxe.io.Bytes {}
@:keep @:file("assets/week6/music/Lunchbox.mp3") @:noCompletion #if display private #end class __ASSET__assets_week6_music_lunchbox_mp3 extends haxe.io.Bytes {}
@:keep @:file("assets/week6/music/LunchboxScary.mp3") @:noCompletion #if display private #end class __ASSET__assets_week6_music_lunchboxscary_mp3 extends haxe.io.Bytes {}
@:keep @:file("assets/week6/sounds/fnf_loss_sfx-pixel.mp3") @:noCompletion #if display private #end class __ASSET__assets_week6_sounds_fnf_loss_sfx_pixel_mp3 extends haxe.io.Bytes {}
@:keep @:file("assets/week6/sounds/pixelText.mp3") @:noCompletion #if display private #end class __ASSET__assets_week6_sounds_pixeltext_mp3 extends haxe.io.Bytes {}
@:keep @:file("assets/week6/sounds/Senpai_Dies.mp3") @:noCompletion #if display private #end class __ASSET__assets_week6_sounds_senpai_dies_mp3 extends haxe.io.Bytes {}
@:keep @:file("assets/week6/week6_stuff_here.txt") @:noCompletion #if display private #end class __ASSET__assets_week6_week6_stuff_here_txt extends haxe.io.Bytes {}
@:keep @:file("art/readme.txt") @:noCompletion #if display private #end class __ASSET__do_not_readme_txt extends haxe.io.Bytes {}
@:keep @:file("assets/fonts/fonts-go-here.txt") @:noCompletion #if display private #end class __ASSET__assets_fonts_fonts_go_here_txt extends haxe.io.Bytes {}
@:keep @:font("export/release/html5/obj/webfont/pixel.otf") @:noCompletion #if display private #end class __ASSET__assets_fonts_pixel_otf extends lime.text.Font {}
@:keep @:font("export/release/html5/obj/webfont/vcr.ttf") @:noCompletion #if display private #end class __ASSET__assets_fonts_vcr_ttf extends lime.text.Font {}
@:keep @:file("C:/HaxeToolkit/haxe/lib/flixel/4,9,0/assets/sounds/beep.mp3") @:noCompletion #if display private #end class __ASSET__flixel_sounds_beep_mp3 extends haxe.io.Bytes {}
@:keep @:file("C:/HaxeToolkit/haxe/lib/flixel/4,9,0/assets/sounds/flixel.mp3") @:noCompletion #if display private #end class __ASSET__flixel_sounds_flixel_mp3 extends haxe.io.Bytes {}
@:keep @:file("C:/HaxeToolkit/haxe/lib/flixel/4,9,0/assets/sounds/beep.ogg") @:noCompletion #if display private #end class __ASSET__flixel_sounds_beep_ogg extends haxe.io.Bytes {}
@:keep @:file("C:/HaxeToolkit/haxe/lib/flixel/4,9,0/assets/sounds/flixel.ogg") @:noCompletion #if display private #end class __ASSET__flixel_sounds_flixel_ogg extends haxe.io.Bytes {}
@:keep @:font("export/release/html5/obj/webfont/nokiafc22.ttf") @:noCompletion #if display private #end class __ASSET__flixel_fonts_nokiafc22_ttf extends lime.text.Font {}
@:keep @:font("export/release/html5/obj/webfont/monsterrat.ttf") @:noCompletion #if display private #end class __ASSET__flixel_fonts_monsterrat_ttf extends lime.text.Font {}
@:keep @:image("C:/HaxeToolkit/haxe/lib/flixel/4,9,0/assets/images/ui/button.png") @:noCompletion #if display private #end class __ASSET__flixel_images_ui_button_png extends lime.graphics.Image {}
@:keep @:image("C:/HaxeToolkit/haxe/lib/flixel/4,9,0/assets/images/logo/default.png") @:noCompletion #if display private #end class __ASSET__flixel_images_logo_default_png extends lime.graphics.Image {}
@:keep @:image("C:/HaxeToolkit/haxe/lib/flixel-ui/2,4,0/assets/images/box.png") @:noCompletion #if display private #end class __ASSET__flixel_flixel_ui_img_box_png extends lime.graphics.Image {}
@:keep @:image("C:/HaxeToolkit/haxe/lib/flixel-ui/2,4,0/assets/images/button.png") @:noCompletion #if display private #end class __ASSET__flixel_flixel_ui_img_button_png extends lime.graphics.Image {}
@:keep @:image("C:/HaxeToolkit/haxe/lib/flixel-ui/2,4,0/assets/images/button_arrow_down.png") @:noCompletion #if display private #end class __ASSET__flixel_flixel_ui_img_button_arrow_down_png extends lime.graphics.Image {}
@:keep @:image("C:/HaxeToolkit/haxe/lib/flixel-ui/2,4,0/assets/images/button_arrow_left.png") @:noCompletion #if display private #end class __ASSET__flixel_flixel_ui_img_button_arrow_left_png extends lime.graphics.Image {}
@:keep @:image("C:/HaxeToolkit/haxe/lib/flixel-ui/2,4,0/assets/images/button_arrow_right.png") @:noCompletion #if display private #end class __ASSET__flixel_flixel_ui_img_button_arrow_right_png extends lime.graphics.Image {}
@:keep @:image("C:/HaxeToolkit/haxe/lib/flixel-ui/2,4,0/assets/images/button_arrow_up.png") @:noCompletion #if display private #end class __ASSET__flixel_flixel_ui_img_button_arrow_up_png extends lime.graphics.Image {}
@:keep @:image("C:/HaxeToolkit/haxe/lib/flixel-ui/2,4,0/assets/images/button_thin.png") @:noCompletion #if display private #end class __ASSET__flixel_flixel_ui_img_button_thin_png extends lime.graphics.Image {}
@:keep @:image("C:/HaxeToolkit/haxe/lib/flixel-ui/2,4,0/assets/images/button_toggle.png") @:noCompletion #if display private #end class __ASSET__flixel_flixel_ui_img_button_toggle_png extends lime.graphics.Image {}
@:keep @:image("C:/HaxeToolkit/haxe/lib/flixel-ui/2,4,0/assets/images/check_box.png") @:noCompletion #if display private #end class __ASSET__flixel_flixel_ui_img_check_box_png extends lime.graphics.Image {}
@:keep @:image("C:/HaxeToolkit/haxe/lib/flixel-ui/2,4,0/assets/images/check_mark.png") @:noCompletion #if display private #end class __ASSET__flixel_flixel_ui_img_check_mark_png extends lime.graphics.Image {}
@:keep @:image("C:/HaxeToolkit/haxe/lib/flixel-ui/2,4,0/assets/images/chrome.png") @:noCompletion #if display private #end class __ASSET__flixel_flixel_ui_img_chrome_png extends lime.graphics.Image {}
@:keep @:image("C:/HaxeToolkit/haxe/lib/flixel-ui/2,4,0/assets/images/chrome_flat.png") @:noCompletion #if display private #end class __ASSET__flixel_flixel_ui_img_chrome_flat_png extends lime.graphics.Image {}
@:keep @:image("C:/HaxeToolkit/haxe/lib/flixel-ui/2,4,0/assets/images/chrome_inset.png") @:noCompletion #if display private #end class __ASSET__flixel_flixel_ui_img_chrome_inset_png extends lime.graphics.Image {}
@:keep @:image("C:/HaxeToolkit/haxe/lib/flixel-ui/2,4,0/assets/images/chrome_light.png") @:noCompletion #if display private #end class __ASSET__flixel_flixel_ui_img_chrome_light_png extends lime.graphics.Image {}
@:keep @:image("C:/HaxeToolkit/haxe/lib/flixel-ui/2,4,0/assets/images/dropdown_mark.png") @:noCompletion #if display private #end class __ASSET__flixel_flixel_ui_img_dropdown_mark_png extends lime.graphics.Image {}
@:keep @:image("C:/HaxeToolkit/haxe/lib/flixel-ui/2,4,0/assets/images/finger_big.png") @:noCompletion #if display private #end class __ASSET__flixel_flixel_ui_img_finger_big_png extends lime.graphics.Image {}
@:keep @:image("C:/HaxeToolkit/haxe/lib/flixel-ui/2,4,0/assets/images/finger_small.png") @:noCompletion #if display private #end class __ASSET__flixel_flixel_ui_img_finger_small_png extends lime.graphics.Image {}
@:keep @:image("C:/HaxeToolkit/haxe/lib/flixel-ui/2,4,0/assets/images/hilight.png") @:noCompletion #if display private #end class __ASSET__flixel_flixel_ui_img_hilight_png extends lime.graphics.Image {}
@:keep @:image("C:/HaxeToolkit/haxe/lib/flixel-ui/2,4,0/assets/images/invis.png") @:noCompletion #if display private #end class __ASSET__flixel_flixel_ui_img_invis_png extends lime.graphics.Image {}
@:keep @:image("C:/HaxeToolkit/haxe/lib/flixel-ui/2,4,0/assets/images/minus_mark.png") @:noCompletion #if display private #end class __ASSET__flixel_flixel_ui_img_minus_mark_png extends lime.graphics.Image {}
@:keep @:image("C:/HaxeToolkit/haxe/lib/flixel-ui/2,4,0/assets/images/plus_mark.png") @:noCompletion #if display private #end class __ASSET__flixel_flixel_ui_img_plus_mark_png extends lime.graphics.Image {}
@:keep @:image("C:/HaxeToolkit/haxe/lib/flixel-ui/2,4,0/assets/images/radio.png") @:noCompletion #if display private #end class __ASSET__flixel_flixel_ui_img_radio_png extends lime.graphics.Image {}
@:keep @:image("C:/HaxeToolkit/haxe/lib/flixel-ui/2,4,0/assets/images/radio_dot.png") @:noCompletion #if display private #end class __ASSET__flixel_flixel_ui_img_radio_dot_png extends lime.graphics.Image {}
@:keep @:image("C:/HaxeToolkit/haxe/lib/flixel-ui/2,4,0/assets/images/swatch.png") @:noCompletion #if display private #end class __ASSET__flixel_flixel_ui_img_swatch_png extends lime.graphics.Image {}
@:keep @:image("C:/HaxeToolkit/haxe/lib/flixel-ui/2,4,0/assets/images/tab.png") @:noCompletion #if display private #end class __ASSET__flixel_flixel_ui_img_tab_png extends lime.graphics.Image {}
@:keep @:image("C:/HaxeToolkit/haxe/lib/flixel-ui/2,4,0/assets/images/tab_back.png") @:noCompletion #if display private #end class __ASSET__flixel_flixel_ui_img_tab_back_png extends lime.graphics.Image {}
@:keep @:image("C:/HaxeToolkit/haxe/lib/flixel-ui/2,4,0/assets/images/tooltip_arrow.png") @:noCompletion #if display private #end class __ASSET__flixel_flixel_ui_img_tooltip_arrow_png extends lime.graphics.Image {}
@:keep @:file("C:/HaxeToolkit/haxe/lib/flixel-ui/2,4,0/assets/xml/defaults.xml") @:noCompletion #if display private #end class __ASSET__flixel_flixel_ui_xml_defaults_xml extends haxe.io.Bytes {}
@:keep @:file("C:/HaxeToolkit/haxe/lib/flixel-ui/2,4,0/assets/xml/default_loading_screen.xml") @:noCompletion #if display private #end class __ASSET__flixel_flixel_ui_xml_default_loading_screen_xml extends haxe.io.Bytes {}
@:keep @:file("C:/HaxeToolkit/haxe/lib/flixel-ui/2,4,0/assets/xml/default_popup.xml") @:noCompletion #if display private #end class __ASSET__flixel_flixel_ui_xml_default_popup_xml extends haxe.io.Bytes {}
@:keep @:file("") @:noCompletion #if display private #end class __ASSET__manifest_default_json extends haxe.io.Bytes {}



#else

@:keep @:expose('__ASSET__assets_fonts_pixel_otf') @:noCompletion #if display private #end class __ASSET__assets_fonts_pixel_otf extends lime.text.Font { public function new () { #if !html5 __fontPath = "assets/fonts/pixel"; #else ascender = 1125; descender = -250; height = 1375; numGlyphs = 262; underlinePosition = -143; underlineThickness = 20; unitsPerEM = 1000; #end name = "Pixel Arial 11 Bold"; super (); }}
@:keep @:expose('__ASSET__assets_fonts_vcr_ttf') @:noCompletion #if display private #end class __ASSET__assets_fonts_vcr_ttf extends lime.text.Font { public function new () { #if !html5 __fontPath = "assets/fonts/vcr"; #else ascender = 1800; descender = 0; height = 2000; numGlyphs = 204; underlinePosition = -292; underlineThickness = 150; unitsPerEM = 2048; #end name = "VCR OSD Mono"; super (); }}
@:keep @:expose('__ASSET__flixel_fonts_nokiafc22_ttf') @:noCompletion #if display private #end class __ASSET__flixel_fonts_nokiafc22_ttf extends lime.text.Font { public function new () { #if !html5 __fontPath = "flixel/fonts/nokiafc22"; #else ascender = 2048; descender = -512; height = 2816; numGlyphs = 172; underlinePosition = -640; underlineThickness = 256; unitsPerEM = 2048; #end name = "Nokia Cellphone FC Small"; super (); }}
@:keep @:expose('__ASSET__flixel_fonts_monsterrat_ttf') @:noCompletion #if display private #end class __ASSET__flixel_fonts_monsterrat_ttf extends lime.text.Font { public function new () { #if !html5 __fontPath = "flixel/fonts/monsterrat"; #else ascender = 968; descender = -251; height = 1219; numGlyphs = 263; underlinePosition = -150; underlineThickness = 50; unitsPerEM = 1000; #end name = "Monsterrat"; super (); }}


#end

#if (openfl && !flash)

#if html5
@:keep @:expose('__ASSET__OPENFL__assets_fonts_pixel_otf') @:noCompletion #if display private #end class __ASSET__OPENFL__assets_fonts_pixel_otf extends openfl.text.Font { public function new () { __fromLimeFont (new __ASSET__assets_fonts_pixel_otf ()); super (); }}
@:keep @:expose('__ASSET__OPENFL__assets_fonts_vcr_ttf') @:noCompletion #if display private #end class __ASSET__OPENFL__assets_fonts_vcr_ttf extends openfl.text.Font { public function new () { __fromLimeFont (new __ASSET__assets_fonts_vcr_ttf ()); super (); }}
@:keep @:expose('__ASSET__OPENFL__flixel_fonts_nokiafc22_ttf') @:noCompletion #if display private #end class __ASSET__OPENFL__flixel_fonts_nokiafc22_ttf extends openfl.text.Font { public function new () { __fromLimeFont (new __ASSET__flixel_fonts_nokiafc22_ttf ()); super (); }}
@:keep @:expose('__ASSET__OPENFL__flixel_fonts_monsterrat_ttf') @:noCompletion #if display private #end class __ASSET__OPENFL__flixel_fonts_monsterrat_ttf extends openfl.text.Font { public function new () { __fromLimeFont (new __ASSET__flixel_fonts_monsterrat_ttf ()); super (); }}

#else
@:keep @:expose('__ASSET__OPENFL__assets_fonts_pixel_otf') @:noCompletion #if display private #end class __ASSET__OPENFL__assets_fonts_pixel_otf extends openfl.text.Font { public function new () { __fromLimeFont (new __ASSET__assets_fonts_pixel_otf ()); super (); }}
@:keep @:expose('__ASSET__OPENFL__assets_fonts_vcr_ttf') @:noCompletion #if display private #end class __ASSET__OPENFL__assets_fonts_vcr_ttf extends openfl.text.Font { public function new () { __fromLimeFont (new __ASSET__assets_fonts_vcr_ttf ()); super (); }}
@:keep @:expose('__ASSET__OPENFL__flixel_fonts_nokiafc22_ttf') @:noCompletion #if display private #end class __ASSET__OPENFL__flixel_fonts_nokiafc22_ttf extends openfl.text.Font { public function new () { __fromLimeFont (new __ASSET__flixel_fonts_nokiafc22_ttf ()); super (); }}
@:keep @:expose('__ASSET__OPENFL__flixel_fonts_monsterrat_ttf') @:noCompletion #if display private #end class __ASSET__OPENFL__flixel_fonts_monsterrat_ttf extends openfl.text.Font { public function new () { __fromLimeFont (new __ASSET__flixel_fonts_monsterrat_ttf ()); super (); }}

#end

#end
#end

#end
