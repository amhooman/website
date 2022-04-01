// graphics

var fonts_loader = new PIXI.loaders.Loader();

fonts_loader
	.add("undertale", "fonts/undertale.fnt")
	.add("numbers", "fonts/numbers.fnt")
	.add("speechbubble", "fonts/speechbubble.fnt")
	.add("undertale_image", "fonts/undertale.png")
	.add("numbers_image", "fonts/numbers.png")
	.add("speechbubble_image", "fonts/speechbubble.png")
	.on("complete", function(loader, resources) {
		process_fonts(resources);
	})
;

function process_fonts(resources) {

	// debugger;

	resources["undertale_image"].texture.baseTexture.scaleMode = PIXI.SCALE_MODES.NEAREST;
	resources["numbers_image"].texture.baseTexture.scaleMode = PIXI.SCALE_MODES.NEAREST;
	resources["speechbubble_image"].texture.baseTexture.scaleMode = PIXI.SCALE_MODES.NEAREST;

	markAssetLoaded("fonts");

}
