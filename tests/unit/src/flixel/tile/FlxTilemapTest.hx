package flixel.tile;

import flash.display.BitmapData;
import flash.errors.ArgumentError;
import flixel.graphics.FlxGraphic;
import flixel.math.FlxPoint;
import flixel.tile.FlxTilemap;
import massive.munit.Assert;
using flixel.util.FlxArrayUtil;
using StringTools;

class FlxTilemapTest extends FlxTest
{
	var tilemap:FlxTilemap;
	var sampleMapString:String;
	var sampleMapArray:Array<Int>;
	
	@Before
	function before()
	{
		tilemap = new FlxTilemap();
		destroyable = tilemap;
		
		sampleMapString = "0,1,0,1[nl]1,1,1,1[nl]1,0,0,1[nl]";
		sampleMapArray = [
			0, 1, 0, 1,
			1, 1, 1, 1,
			1, 0, 0, 1];
	}
	
	@Test
	function test1x1Map()
	{
		tilemap.loadMapFromCSV("1", getBitmapData(), 8, 8);
		
		try
		{
			tilemap.draw();
		}
		catch (error:ArgumentError)
		{
			Assert.fail(error.message);
		}
		
		Assert.areEqual(1, tilemap.getData()[0]);
	}
	
	@Test
	function testLoadMapArray()
	{
		var mapData = [0, 1, 0, 1, 1, 1];
		tilemap.loadMapFromArray(mapData, 3, 2, getBitmapData(), 8, 8);
		
		Assert.areEqual(3, tilemap.widthInTiles);
		Assert.areEqual(2, tilemap.heightInTiles);
		Assert.isTrue([0, 1, 0, 1, 1, 1].equals(tilemap.getData()));
	}
	
	@Test
	function testLoadMap2DArray()
	{
		var mapData = [
			[0, 1, 0],
			[1, 1, 1]];
		tilemap.loadMapFrom2DArray(mapData, getBitmapData(), 8, 8);
		
		Assert.areEqual(3, tilemap.widthInTiles);
		Assert.areEqual(2, tilemap.heightInTiles);
		Assert.isTrue([0, 1, 0, 1, 1, 1].equals(tilemap.getData()));
	}
	
	@Test
	function testLoadMapFromCSVWindowsNewlines()
	{
		testLoadMapFromCSVWithNewline(sampleMapString, "\r\n");
	}
	
	@Test
	function testLoadMapFromCSVUnixNewlines()
	{
		testLoadMapFromCSVWithNewline(sampleMapString, "\n");
	}
	
	@Test // #1375
	function testLoadMapFromCSVMacNewlines()
	{
		testLoadMapFromCSVWithNewline(sampleMapString, "\r");
	}
	
	@Test // #1511
	function testLoadMapInvalidGraphicPathNoCrash()
	{
		tilemap.loadMapFromArray([1], 1, 1, "assets/invalid");
	}
	
	@Test  // #1546
	function testOffMapOverlap()
	{
		tilemap.loadMapFrom2DArray([[1], [0]], getBitmapData(), 8, 8);
		var sprite = new FlxSprite( -2, 10);
		Assert.isFalse(tilemap.overlapsWithCallback(sprite));
	}
	
	@Test // #1550
	function testLoadMapFromCSVTrailingNewline()
	{
		testLoadMapFromCSVWithNewline(sampleMapString + "[nl]", "\n");
	}
	
	function testLoadMapFromCSVWithNewline(csv:String, newlines:String)
	{
		tilemap.loadMapFromCSV(csv.replace("[nl]", newlines), getBitmapData(), 8, 8);
		
		Assert.areEqual(4, tilemap.widthInTiles);
		Assert.areEqual(3, tilemap.heightInTiles);
		Assert.isTrue(sampleMapArray.equals(tilemap.getData()));
	}
	
	@Test //#1617
	function testRayEmpty()
	{
		var mapData = [0, 0, 0]; //3x1 
		tilemap.loadMapFromArray(mapData, 3, 1, getBitmapData(), 8, 8);
		
		Assert.isTrue(tilemap.ray(new FlxPoint(0, tilemap.height/2), new FlxPoint(tilemap.width, tilemap.height/2)));
	}
	
	@Test //#1617
	function testRayStraight()
	{
		var mapData = [0, 1, 0]; //3x1 with a solid block in the middle
		tilemap.loadMapFromArray(mapData, 3, 1, getBitmapData(), 8, 8);
		
		Assert.isFalse(tilemap.ray(new FlxPoint(0, tilemap.height/2), new FlxPoint(tilemap.width, tilemap.height/2)));
	}
	
	@Test //#1617
	function testRayImperfectDiagonal()
	{
		var mapData = [0, 0, 0, 0, 1, 0, 0, 0, 0]; //3x3 with a solid block in the middle
		tilemap.loadMapFromArray(mapData, 3, 3, getBitmapData(), 8, 8);
		
		Assert.isFalse(tilemap.ray(new FlxPoint(0, 0), new FlxPoint(tilemap.width-tilemap.width/8, tilemap.height)));
	}
	
	@Test //#1617
	function testRayPerfectDiagonal()
	{
		var mapData = [0, 0, 0, 0, 1, 0, 0, 0, 0]; //3x3 with a solid block in the middle
		tilemap.loadMapFromArray(mapData, 3, 3, getBitmapData(), 8, 8);
		
		Assert.isFalse(tilemap.ray(new FlxPoint(0, 0), new FlxPoint(tilemap.width, tilemap.height)));
	}
	
	function getBitmapData()
	{
		return new BitmapData(16, 8);
	}
}
