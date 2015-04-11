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



class Design_16_16_SpawnEnemies extends ActorScript
{          	
	
public var _SpawningInterval:Float;

public var _Waves:Array<Dynamic>;

public var _Path:Array<Dynamic>;

public var _TypeA:ActorType;

public var _TypeB:ActorType;

public var _TypeC:ActorType;

public var _TypeD:ActorType;
    
/* ========================= Custom Block ========================= */


/* Params are:__Self */
public function _customBlock_Start_Wave():Void
{
var __Self:Actor = actor;
        if((_Waves.length == 0))
{
            return;
}

        trace("" + "DEBUG 1");
        __Self.say("Spawn Enemies", "_customBlock_execute_wave", [("" + _Waves[Std.int(0)]).split(" ")]);
}
    
/* ========================= Custom Block ========================= */


/* Params are:__Self __Definition */
public function _customBlock_execute_wave(__Definition:Array<Dynamic>):Void
{
var __Self:Actor = actor;
        runPeriodically(1000 * _SpawningInterval, function(timeTask:TimedTask):Void {
                    if((__Definition.length == 0))
{
                        timeTask.repeats = false;
return;
}

                    trace("" + "DEBUG 2");
                    trace("" + (("" + "DEBUGX ") + ("" + __Definition[Std.int(0)])));
                    __Self.say("Spawn Enemies", "_customBlock_spawn_enemy", [__Definition[Std.int(0)]]);
                    __Definition.splice(Std.int(0), 1);
}, actor);
}
    
/* ========================= Custom Block ========================= */


/* Params are:__Self __Type */
public function _customBlock_spawn_enemy(__Type:String):Void
{
var __Self:Actor = actor;
        trace("" + "DEBUG 3");
        if((__Type == "X"))
{
            return;
}

        if((__Type == "A"))
{
            createRecycledActor(_TypeA, __Self.getX(), actor.getY(), Script.FRONT);
}

        if((__Type == "B"))
{
            createRecycledActor(_TypeB, __Self.getX(), actor.getY(), Script.FRONT);
}

        if((__Type == "C"))
{
            createRecycledActor(_TypeC, __Self.getX(), actor.getY(), Script.FRONT);
}

        if((__Type == "D"))
{
            createRecycledActor(_TypeD, __Self.getX(), actor.getY(), Script.FRONT);
}

        actor.say("Spawn Enemies", "_customBlock_activate_enemy", [getLastCreatedActor()]);
}
    
/* ========================= Custom Block ========================= */


/* Params are:__Self __Enemy */
public function _customBlock_activate_enemy(__Enemy:Actor):Void
{
var __Self:Actor = actor;
        trace("" + "DEBUG 4");
        for(item in cast(_Path, Array<Dynamic>))
{
            trace("" + "DEBUG 4.5");
            trace("" + (("" + "DEBUGJDMX1 ") + ("" + item)));
            trace("" + (("" + "DEBUGJDMX2 ") + ("" + ("" + item).split(" ")[Std.int(0)])));
            trace("" + ("" + _Path[Std.int(item)]).split(" ")[Std.int(1)]);
            trace("" + "DEBUG 5");
            __Enemy.say("Follow Path", "_customBlock_AddNode", [("" + item).split(" ")[Std.int(0)],("" + item).split(" ")[Std.int(1)]]);
            trace("" + "DEBUG 6");
}

}

 
 	public function new(dummy:Int, actor:Actor, dummy2:Engine)
	{
		super(actor);
		nameMap.set("Spawning Interval", "_SpawningInterval");
_SpawningInterval = 0.0;
nameMap.set("Waves", "_Waves");
_Waves = [];
nameMap.set("Path", "_Path");
_Path = [];
nameMap.set("Type A", "_TypeA");
nameMap.set("Type B", "_TypeB");
nameMap.set("Type C", "_TypeC");
nameMap.set("Type D", "_TypeD");
nameMap.set("Actor", "actor");

	}
	
	override public function init()
	{
		    
/* ======================== When Creating ========================= */
        actor.say("Spawn Enemies", "_customBlock_Start_Wave");

	}	      	
	
	override public function forwardMessage(msg:String)
	{
		
	}
}