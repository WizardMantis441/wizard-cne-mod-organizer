import funkin.backend.assets.ModsFolder;
import funkin.backend.system.MainState;
import sys.FileSystem;
import flixel.text.FlxText.FlxTextBorderStyle;

var modFolders:Array<String> = ["mods"];
var modFolderSizes:Array<Int> = [];

var menuText:FlxText;
static var curModFolderSelected:Int = 0;

function create() {
    for (folder in FileSystem.readDirectory(''))
        if (FileSystem.isDirectory(folder) && StringTools.startsWith(folder, "mods-") && folder.length > 5)
            modFolders.push(folder);

    for (folder in modFolders)
        modFolderSizes.push(getFolderSize(folder));

    if (curModFolderSelected > modFolders.length - 1)
        curModFolderSelected = 0;

    menuText = new FlxText(0, 0, FlxG.width, "", 36);
    menuText.borderStyle = FlxTextBorderStyle.OUTLINE;
    menuText.font = Paths.font('vcr.ttf');
    menuText.alignment = 'right';
    menuText.scrollFactor.set();
    menuText.visible = modFolders.length > 1;
}

function postCreate()
    add(menuText);    

function update() {
    curModFolderSelected = FlxMath.wrap(curModFolderSelected - FlxG.mouse.wheel, 0, modFolders.length - 1);

    menuText.text = '(scroll wheel & click to use)\n' + modFolders.length + ' mod folders found!\n';
    for (i in 0...modFolders.length) {
        var name = modFolders[i] == 'mods' ? 'DEFAULT' : StringTools.replace(modFolders[i], 'mods-', '');
        menuText.text += '\n (' + modFolderSizes[i] + ') ' + name + (i == curModFolderSelected ? ' <<' : ' -');
    }

    if (FlxG.mouse.justPressed && ModsFolder.modsPath != './' + modFolders[curModFolderSelected] + '/') {
        ModsFolder.modsPath = './' + modFolders[curModFolderSelected] + '/';
        resetList();
    }
}

function resetList() {
    mods = ModsFolder.getModsList();
    mods.push(null);

    alphabets.clear();
    for (mod in mods) {
        var a = new Alphabet(0, 0, mod == null ? "DISABLE MODS" : mod, true);
        a.isMenuItem = true;
        a.scrollFactor.set();
        alphabets.add(a);
    }

    changeSelection(0, true);
}

function getFolderSize(folder) {
    var size:Int = 0;
    for (actualMod in FileSystem.readDirectory(folder))
        if (FileSystem.isDirectory(folder + '/' + actualMod))
            size++;

    return size;
}