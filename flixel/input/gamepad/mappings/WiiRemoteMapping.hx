package flixel.input.gamepad.mappings;

import flixel.input.gamepad.FlxGamepad.FlxGamepadAttachment;
import flixel.input.gamepad.FlxGamepadInputID;
import flixel.input.gamepad.id.WiiRemoteID;
import flixel.input.gamepad.mappings.FlxGamepadMapping;

class WiiRemoteMapping extends FlxGamepadMapping
{
	#if FLX_JOYSTICK_API
	private static inline var LEFT_ANALOG_STICK_FAKE_X:Int = 20;
	private static inline var LEFT_ANALOG_STICK_FAKE_Y:Int = 21;
	private static inline var RIGHT_ANALOG_STICK_FAKE_X:Int = 22;
	private static inline var RIGHT_ANALOG_STICK_FAKE_Y:Int = 23;
	#end
	
	override function initValues():Void 
	{
		supportsMotion = true;
		//when Julian updates his driver, this can be set to "true"
		supportsPointer = false;
	}
	
	override public function getID(rawID:Int):FlxGamepadInputID 
	{
		return switch (attachment)
		{
			case WII_CLASSIC_CONTROLLER: getIDClassicController(rawID);
			case WII_NUNCHUCK: getIDNunchuk(rawID);
			case NONE: getIDDefault(rawID);
		}
	}
	
	private function getIDClassicController(rawID:Int):FlxGamepadInputID
	{
		return switch (rawID)
		{
			case WiiRemoteID.CLASSIC_A: B;
			case WiiRemoteID.CLASSIC_B: A;
			case WiiRemoteID.CLASSIC_X: Y;
			case WiiRemoteID.CLASSIC_Y: X;
			case WiiRemoteID.CLASSIC_SELECT: BACK;
			case WiiRemoteID.CLASSIC_HOME: GUIDE;
			case WiiRemoteID.CLASSIC_START: START;
			case WiiRemoteID.CLASSIC_ZL: LEFT_SHOULDER;
			case WiiRemoteID.CLASSIC_ZR: RIGHT_SHOULDER;
			case WiiRemoteID.CLASSIC_L: LEFT_TRIGGER;
			case WiiRemoteID.CLASSIC_R: RIGHT_TRIGGER;
			case WiiRemoteID.CLASSIC_DPAD_UP: DPAD_UP;
			case WiiRemoteID.CLASSIC_DPAD_DOWN: DPAD_DOWN;
			case WiiRemoteID.CLASSIC_DPAD_LEFT: DPAD_LEFT;
			case WiiRemoteID.CLASSIC_DPAD_RIGHT: DPAD_RIGHT;
			case WiiRemoteID.CLASSIC_ONE: EXTRA_0;
			case WiiRemoteID.CLASSIC_TWO: EXTRA_1;
			default: NONE;
		}
	}
	
	private function getIDNunchuk(rawID:Int):FlxGamepadInputID
	{
		return switch (rawID)
		{
			case WiiRemoteID.NUNCHUK_A: A;
			case WiiRemoteID.NUNCHUK_B: B;
			case WiiRemoteID.NUNCHUK_C: LEFT_SHOULDER;
			case WiiRemoteID.NUNCHUK_Z: LEFT_TRIGGER;
			case WiiRemoteID.NUNCHUK_ONE: X;
			case WiiRemoteID.NUNCHUK_TWO: Y;
			case WiiRemoteID.NUNCHUK_MINUS: BACK;
			case WiiRemoteID.NUNCHUK_PLUS: START;
			case WiiRemoteID.NUNCHUK_HOME: GUIDE;
			case WiiRemoteID.NUNCHUK_DPAD_UP: DPAD_UP;
			case WiiRemoteID.NUNCHUK_DPAD_DOWN: DPAD_DOWN;
			case WiiRemoteID.NUNCHUK_DPAD_LEFT: DPAD_LEFT;
			case WiiRemoteID.NUNCHUK_DPAD_RIGHT: DPAD_RIGHT;
			default: NONE;
		}
	}
	
	private function getIDDefault(rawID:Int):FlxGamepadInputID
	{
		return switch (rawID)
		{
			case WiiRemoteID.REMOTE_A: A;
			case WiiRemoteID.REMOTE_B: B;
			case WiiRemoteID.REMOTE_ONE: X;
			case WiiRemoteID.REMOTE_TWO: Y;
			case WiiRemoteID.REMOTE_MINUS: BACK;
			case WiiRemoteID.REMOTE_HOME: GUIDE;
			case WiiRemoteID.REMOTE_PLUS: START;
			case WiiRemoteID.REMOTE_DPAD_UP: DPAD_UP;
			case WiiRemoteID.REMOTE_DPAD_DOWN: DPAD_DOWN;
			case WiiRemoteID.REMOTE_DPAD_LEFT: DPAD_LEFT;
			case WiiRemoteID.REMOTE_DPAD_RIGHT: DPAD_RIGHT;
			default: NONE;
		}
	}
	
	override public function getRawID(ID:FlxGamepadInputID):Int 
	{
		return switch (attachment)
		{
			case WII_CLASSIC_CONTROLLER: getRawClassicController(ID);
			case WII_NUNCHUCK: getRawNunchuk(ID);
			case NONE: getRawDefault(ID);
		}
	}
	
	private function getRawClassicController(ID:FlxGamepadInputID):Int
	{
		return switch (ID)
		{
			case A: WiiRemoteID.CLASSIC_B;
			case B: WiiRemoteID.CLASSIC_A;
			case X: WiiRemoteID.CLASSIC_Y;
			case Y: WiiRemoteID.CLASSIC_X;
			case DPAD_UP: WiiRemoteID.CLASSIC_DPAD_UP;
			case DPAD_DOWN: WiiRemoteID.CLASSIC_DPAD_DOWN;
			case DPAD_LEFT: WiiRemoteID.CLASSIC_DPAD_LEFT;
			case DPAD_RIGHT: WiiRemoteID.CLASSIC_DPAD_RIGHT;
			case BACK: WiiRemoteID.CLASSIC_SELECT;
			case GUIDE: WiiRemoteID.CLASSIC_HOME;
			case START: WiiRemoteID.CLASSIC_START;
			case LEFT_SHOULDER: WiiRemoteID.CLASSIC_ZL;
			case RIGHT_SHOULDER: WiiRemoteID.CLASSIC_ZR;
			case LEFT_TRIGGER: WiiRemoteID.CLASSIC_L;
			case RIGHT_TRIGGER: WiiRemoteID.CLASSIC_R;
			case EXTRA_0: WiiRemoteID.CLASSIC_ONE;
			case EXTRA_1: WiiRemoteID.CLASSIC_TWO;
			default: -1;
		}
	}
	
	private function getRawNunchuk(ID:FlxGamepadInputID):Int
	{
		return switch (ID)
		{
			case A: WiiRemoteID.NUNCHUK_A;
			case B: WiiRemoteID.NUNCHUK_B;
			case LEFT_SHOULDER: WiiRemoteID.NUNCHUK_C;
			case LEFT_TRIGGER: WiiRemoteID.NUNCHUK_Z;
			case X: WiiRemoteID.NUNCHUK_ONE;
			case Y: WiiRemoteID.NUNCHUK_TWO;
			case BACK: WiiRemoteID.NUNCHUK_MINUS;
			case START: WiiRemoteID.NUNCHUK_PLUS;
			case GUIDE: WiiRemoteID.NUNCHUK_HOME;
			case DPAD_UP: WiiRemoteID.NUNCHUK_DPAD_UP;
			case DPAD_DOWN: WiiRemoteID.NUNCHUK_DPAD_DOWN;
			case DPAD_LEFT: WiiRemoteID.NUNCHUK_DPAD_LEFT;
			case DPAD_RIGHT: WiiRemoteID.NUNCHUK_DPAD_RIGHT;
			case TILT_PITCH: WiiRemoteID.NUNCHUK_TILT_PITCH;
			case TILT_ROLL: WiiRemoteID.NUNCHUK_TILT_ROLL;
			default: -1;
		}
	}
	
	private function getRawDefault(ID:FlxGamepadInputID):Int
	{
		return switch (ID)
		{
			case A: WiiRemoteID.REMOTE_A;
			case B: WiiRemoteID.REMOTE_B;
			case X: WiiRemoteID.REMOTE_ONE;
			case Y: WiiRemoteID.REMOTE_TWO;
			case DPAD_UP: WiiRemoteID.REMOTE_DPAD_UP;
			case DPAD_DOWN: WiiRemoteID.REMOTE_DPAD_DOWN;
			case DPAD_LEFT: WiiRemoteID.REMOTE_DPAD_LEFT;
			case DPAD_RIGHT: WiiRemoteID.REMOTE_DPAD_RIGHT;
			case BACK: WiiRemoteID.REMOTE_MINUS;
			case GUIDE: WiiRemoteID.REMOTE_HOME;
			case START: WiiRemoteID.REMOTE_PLUS;
			case TILT_PITCH: WiiRemoteID.REMOTE_TILT_PITCH;
			case TILT_ROLL: WiiRemoteID.REMOTE_TILT_ROLL;
			default: -1;
		}
	}
	
	override public function isAxisForMotion(ID:FlxGamepadInputID):Bool 
	{
		if (attachment == NONE)
		{
			if (ID == WiiRemoteID.REMOTE_TILT_PITCH || ID == WiiRemoteID.REMOTE_TILT_ROLL)
				return true;
		}
		else if (attachment == WII_NUNCHUCK)
		{
			if (ID == WiiRemoteID.NUNCHUK_TILT_PITCH || ID == WiiRemoteID.NUNCHUK_TILT_ROLL)
				return true;
		}
		return false;
	}
	
	override public function isAxisFlipped(axisID:Int):Bool 
	{
		return axisID == WiiRemoteID.LEFT_TRIGGER_FAKE;
	}
	
	#if FLX_JOYSTICK_API
	//Analog stick and trigger values overlap with regular buttons so we remap to "fake" button ID's
	override public function axisIndexToRawID(axisID:Int):Int 
	{
		//return null for this unused access so it doesn't overlap a button input
		if (attachment == NONE && axisID == WiiRemoteID.REMOTE_NULL_AXIS)
			return -1;
		//return null for this unused access so it doesn't overlap a button input
		else if (attachment == WII_NUNCHUCK && axisID == WiiRemoteID.NUNCHUK_NULL_AXIS)
			return -1;
		
		if (attachment == WII_NUNCHUCK || attachment == WII_CLASSIC_CONTROLLER)
		{
			if (axisID == leftStick.x)
				return LEFT_ANALOG_STICK_FAKE_X;
			else if (axisID == leftStick.y)
				return LEFT_ANALOG_STICK_FAKE_Y;
		}
		else
		{
			if (axisID == leftStick.x)
				return WiiRemoteID.REMOTE_DPAD_X;
			else if (axisID == leftStick.y)
				return WiiRemoteID.REMOTE_DPAD_Y;
		}
		
		if (axisID == rightStick.x)
			return RIGHT_ANALOG_STICK_FAKE_X;
		else if (axisID == rightStick.y)
			return RIGHT_ANALOG_STICK_FAKE_Y;
		
		return axisID;
	}

	override public function checkForFakeAxis(ID:FlxGamepadInputID):Int 
	{
		if (attachment == WII_NUNCHUCK && ID == FlxGamepadInputID.LEFT_TRIGGER)
			return WiiRemoteID.NUNCHUK_Z;
	
		return -1;
	}
	#end
	
	override function set_attachment(attachment:FlxGamepadAttachment):FlxGamepadAttachment 
	{
		leftStick = switch (attachment)
		{
			case WII_NUNCHUCK, WII_CLASSIC_CONTROLLER: WiiRemoteID.LEFT_ANALOG_STICK;
			case NONE: WiiRemoteID.REMOTE_DPAD;
		}
		
		rightStick = switch (attachment)
		{
			case WII_CLASSIC_CONTROLLER: WiiRemoteID.RIGHT_ANALOG_STICK;
			default: null;
		}
		
		return super.set_attachment(attachment);
	}
}