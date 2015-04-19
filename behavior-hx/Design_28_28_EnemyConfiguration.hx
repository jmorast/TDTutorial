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



class Design_28_28_EnemyConfiguration extends ActorScript
{          	
	
public var _Hitpoints:Float;

public var _PointsWhenKilled:Float;

public var _Speed:Float;

 
 	public function new(dummy:Int, actor:Actor, dummy2:Engine)
	{
		super(actor);
		nameMap.set("Hitpoints", "_Hitpoints");
_Hitpoints = 0.0;
nameMap.set("Points When Killed", "_PointsWhenKilled");
_PointsWhenKilled = 0.0;
nameMap.set("Speed", "_Speed");
_Speed = 0.0;
nameMap.set("Actor", "actor");

	}
	
	override public function init()
	{
		    
/* ======================== When Creating ========================= */
        actor.makeAlwaysSimulate();
    
/* ======================== Specific Actor ======================== */
addWhenCreatedListener(actor, function(list:Array<Dynamic>):Void
{
if(wrapper.enabled)
{
        /* "Health Manager Settings" */
        actor.setValue("Health Manager", "_SpawnActorOnDeath", true);
        actor.setValue("Health Manager", "_ActorTypeToSpawn", getActorType(45));
        actor.setValue("Health Manager", "_ZeroHealthAction", "Kill");
        actor.setValue("Health Manager", "_MaximumHealth", _Hitpoints);
        actor.say("Health Manager", "_customBlock_SetHealth", [_Hitpoints]);
        /* "Follow Path Settings" */
        actor.setValue("Follow Path", "_DefaultSpeed", _Speed);
        actor.setValue("Follow Path", "_JumpToStart", false);
        actor.setValue("Follow Path", "_Loop", false);
        /* "Flicker When Damaged Settings" */
        actor.say("Flicker when Damaged", "_customBlock_flicker_event", [3,.1,"Damaged"]);
        /* "Add Points When Killed Settings" */
        actor.say("Add points when killed", "_customBlock_increase_score_by_points", [_PointsWhenKilled]);
}
});

	}	      	
	
	override public function forwardMessage(msg:String)
	{
		
	}
}