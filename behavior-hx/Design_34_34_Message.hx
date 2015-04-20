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



class Design_34_34_Message extends ActorScript
{          	
	
public var _CenterPositionX:Float;

public var _CenterPositionY:Float;

public var _AnimationDuration:Float;
    
/* ========================= Custom Block ========================= */


/* Params are:__Self */
public function _customBlock_ShowMessage():Float
{
var __Self:Actor = actor;
        __Self.moveTo(_CenterPositionX, _CenterPositionY, _AnimationDuration, Back.easeOut);
        return _AnimationDuration;
}

 
 	public function new(dummy:Int, actor:Actor, dummy2:Engine)
	{
		super(actor);
		nameMap.set("Center Position X", "_CenterPositionX");
_CenterPositionX = 0.0;
nameMap.set("Center Position Y", "_CenterPositionY");
_CenterPositionY = 0.0;
nameMap.set("Animation Duration", "_AnimationDuration");
_AnimationDuration = 0.0;
nameMap.set("Actor", "actor");

	}
	
	override public function init()
	{
		    
/* ======================== When Creating ========================= */
        actor.makeAlwaysSimulate();
        _CenterPositionX = asNumber((((getSceneWidth()) / 2) - (actor.getWidth()/2)));
propertyChanged("_CenterPositionX", _CenterPositionX);
        _CenterPositionY = asNumber((((getSceneHeight()) / 2) - (actor.getHeight()/2)));
propertyChanged("_CenterPositionY", _CenterPositionY);
        actor.setX(_CenterPositionX);
        actor.setY(-400);

	}	      	
	
	override public function forwardMessage(msg:String)
	{
		
	}
}