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



class Design_11_11_FlyingBullet extends ActorScript
{          	
	
public var _Target:Actor;

public var _AmountofDamage:Float;

public var _dx:Float;

public var _dy:Float;

public var _MinimumDistance:Float;

public var _BulletSpeed:Float;
    
/* ========================= Custom Block ========================= */


/* Params are:__Self __Target __AmountofDamage */
public function _customBlock_Shoot_Target(__Target:Actor, __AmountofDamage:Float):Void
{
var __Self:Actor = actor;
        _Target = __Target;
propertyChanged("_Target", _Target);
        _AmountofDamage = asNumber(__AmountofDamage);
propertyChanged("_AmountofDamage", _AmountofDamage);
}

 
 	public function new(dummy:Int, actor:Actor, dummy2:Engine)
	{
		super(actor);
		nameMap.set("Target", "_Target");
nameMap.set("Amount of Damage", "_AmountofDamage");
_AmountofDamage = 0.0;
nameMap.set("dx", "_dx");
_dx = 0.0;
nameMap.set("dy", "_dy");
_dy = 0.0;
nameMap.set("Minimum Distance", "_MinimumDistance");
_MinimumDistance = 0.0;
nameMap.set("Bullet Speed", "_BulletSpeed");
_BulletSpeed = 0.0;
nameMap.set("Actor", "actor");

	}
	
	override public function init()
	{
		    
/* ======================== When Updating ========================= */
addWhenUpdatedListener(null, function(elapsedTime:Float, list:Array<Dynamic>):Void
{
if(wrapper.enabled)
{
        if((!hasValue(_Target)))
{
            return;
}

        if(!(_Target.isAlive()))
{
            recycleActor(_Target);
            return;
}

        _dx = asNumber((_Target.getXCenter() - actor.getXCenter()));
propertyChanged("_dx", _dx);
        _dy = asNumber((_Target.getYCenter() - actor.getYCenter()));
propertyChanged("_dy", _dy);
        if(((Math.abs(_dx) < _MinimumDistance) && (Math.abs(_dy) < _MinimumDistance)))
{
            _Target.say("Health Manager", "_customBlock_Damage", [_AmountofDamage]);
            recycleActor(actor);
}

        else
{
            actor.setVelocity(Utils.DEG * (Math.atan2(_dy, _dx)), _BulletSpeed);
}

}
});

	}	      	
	
	override public function forwardMessage(msg:String)
	{
		
	}
}