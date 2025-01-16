import funkin.backend.assets.ModsFolder;

// so u can exit and come back to the same region

function new() {
    if (FlxG.save.data.wiz_modFolder == null) FlxG.save.data.wiz_modFolder = "";
    if (FlxG.save.data.wiz_modPath == null) FlxG.save.data.wiz_modPath = "./mods/";

    ModsFolder.currentModFolder = FlxG.save.data.wiz_modFolder;
    ModsFolder.modsPath = FlxG.save.data.wiz_modPath;
}

function destroy() {
    FlxG.save.data.wiz_modFolder = ModsFolder.currentModFolder;
    FlxG.save.data.wiz_modPath = ModsFolder.modsPath;
}