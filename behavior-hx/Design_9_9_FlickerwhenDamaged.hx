package scripts;

import com.stencyl.graphics.G;
import com.stencyl.graphics.BitmapWrapper;

import com.stencyl.behavior.Script;
import com.stencyl.behavior.Script.*;
import com.stencyl.behavior.ActorScript;
import com.stencyl.behavior.SceneScript;
import com.stencyl.behavior.TimedTask;

import com.stencyl.models.Actor;
import com.stencyl.models.GameModel;
import com.stencyl.models.actor.Animation;
import com.stencyl.models.actor.ActorType;
import com.stencyl.models.actor.Collision;
import com.stencyl.models.actor.Group;
import com.stencyl.models.Scene;
import com.stencyl.models.Sound;
import com.stencyl.models.Region;
import com.stencyl.models.Font;

import com.stencyl.Engine;
import com.stencyl.Input;
import com.stencyl.Key;
import com.stencyl.utils.Utils;

import openfl.ui.Mouse;
import openfl.display.Graphics;
import openfl.display.BlendMode;
import openfl.display.BitmapData;
import openfl.display.Bitmap;
import openfl.events.Event;
import openfl.events.KeyboardEvent;
import openfl.events.TouchEvent;
import openfl.net.URLLoader;

import box2D.common.math.B2Vec2;
import box2D.dynamics.B2Body;
import box2D.dynamics.B2Fixture;
import box2D.dynamics.joints.B2Joint;

import motion.Actuate;
import motion.easing.Back;
import motion.easing.Cubic;
import motion.easing.Elastic;
import motion.easing.Expo;
import motion.easing.Linear;
import motion.easing.Quad;
import motion.easing.Quart;
import motion.easing.Quint;
import motion.easing.Sine;

import com.stencyl.graphics.shaders.BasicShader;
import com.stencyl.graphics.shaders.GrayscaleShader;
import com.stencyl.graphics.shaders.SepiaShader;
import com.stencyl.graphics.shaders.InvertShader;
import com.stencyl.graphics.shaders.GrainShader;
import com.stencyl.graphics.shaders.ExternalShader;
import com.stencyl.graphics.shaders.InlineShader;
import com.stencyl.graphics.shaders.BlurShader;
import com.stencyl.graphics.shaders.SharpenShader;
import com.stencyl.graphics.shaders.ScanlineShader;
import com.stencyl.graphics.shaders.CSBShader;
import com.stencyl.graphics.shaders.HueShader;
import com.stencyl.graphics.shaders.TintShader;
import com.stencyl.graphics.shaders.BloomShader;



class Design_9_9_FlickerwhenDamaged extends ActorScript
{          	
	
public var _DamagedEvent:String;

public var _FlickerDelay:Float;

public var _FlickerCount:Float;

public var _CurrentFlickerCount:Float;
    
/* ========================= Custom Event ========================= */
public function _customEvent_whenThisHears_DamagedEvent():Void
{
        _CurrentFlickerCount = asNumber(0);
propertyChanged("_CurrentFlickerCount", _CurrentFlickerCount);
        _customEvent_flicker();
}

    
/* ========================= Custom Event ========================= */
public function _customEvent_flicker():Void
{
        actor.disableActorDrawing();
        runLater(1000 * _FlickerDelay, function(timeTask:TimedTask):Void {
                    actor.enableActorDrawing();
                    _CurrentFlickerCount += 1;
propertyChanged("_CurrentFlickerCount", _CurrentFlickerCount);
                    if((_CurrentFlickerCount < _FlickerCount))
{
                        runLater(1000 * _FlickerDelay, function(timeTask:TimedTask):Void {
                                    _customEvent_flicker();
}, actor);
}

}, actor);
}

    
/* ========================= Custom Block ========================= */


/* Params are:__Self __FlickerCount __FlickerDelay __Event */
public function _customBlock_flicker_event(__FlickerCount:Float, __FlickerDelay:Float, __Event:String):Void
{
var __Self:Actor = actor;
        _FlickerCount = asNumber(__FlickerCount);
propertyChanged("_FlickerCount", _FlickerCount);
        _FlickerDelay = asNumber(__FlickerDelay);
propertyChanged("_FlickerDelay", _FlickerDelay);
        _DamagedEvent = __Event;
propertyChanged("_DamagedEvent", _DamagedEvent);
}

 
 	public function new(dummy:Int, actor:Actor, dummy2:Engine)
	{
		super(actor);
		nameMap.set("Damaged Event", "_DamagedEvent");
_DamagedEvent = "Damaged";
nameMap.set("Flicker Delay", "_FlickerDelay");
_FlickerDelay = 0.1;
nameMap.set("Flicker Count", "_FlickerCount");
_FlickerCount = 3.0;
nameMap.set("Current Flicker Count", "_CurrentFlickerCount");
_CurrentFlickerCount = 0.0;
nameMap.set("Actor", "actor");

	}
	
	override public function init()
	{
		
	}	      	
	
	override public function forwardMessage(msg:String)
	{
		if(msg == ("_customEvent_" + _DamagedEvent))
{
_customEvent_whenThisHears_DamagedEvent();
return;
}

	}
}