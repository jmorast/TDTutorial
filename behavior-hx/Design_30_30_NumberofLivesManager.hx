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
import box2D.collision.shapes.B2Shape;

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



class Design_30_30_NumberofLivesManager extends SceneScript
{
	
public var _NumberofLives:Float;

public var _CurrentNumberofLives:Float;

public var _NumberofLivesActor:Actor;

public var _NoMoreLivesTriggered:Bool;
    
/* ========================= Custom Block ========================= */


/* Params are:__Amount */
public function _customBlock_decrease_lives(__Amount:Float):Void
{
        _CurrentNumberofLives = asNumber(Math.max(0, (_CurrentNumberofLives - __Amount)));
propertyChanged("_CurrentNumberofLives", _CurrentNumberofLives);
        if((_CurrentNumberofLives == 0))
{
            if(!(_NoMoreLivesTriggered))
{
                shoutToScene("_customEvent_" + "no_more_lives");
                _NoMoreLivesTriggered = true;
propertyChanged("_NoMoreLivesTriggered", _NoMoreLivesTriggered);
}

}

}

 
 	public function new(dummy:Int, dummy2:Engine)
	{
		super();
		nameMap.set("Number of Lives", "_NumberofLives");
_NumberofLives = 0.0;
nameMap.set("Current Number of Lives", "_CurrentNumberofLives");
_CurrentNumberofLives = 0.0;
nameMap.set("Number of Lives Actor", "_NumberofLivesActor");
nameMap.set("No More Lives Triggered?", "_NoMoreLivesTriggered");
_NoMoreLivesTriggered = false;

	}
	
	override public function init()
	{
		    
/* ======================== When Creating ========================= */
        createRecycledActor(getActorType(61), 10, 10, Script.FRONT);
        _NumberofLivesActor = getLastCreatedActor();
propertyChanged("_NumberofLivesActor", _NumberofLivesActor);
        _CurrentNumberofLives = asNumber(_NumberofLives);
propertyChanged("_CurrentNumberofLives", _CurrentNumberofLives);
    
/* ========================= When Drawing ========================= */
addWhenDrawingListener(null, function(g:G, x:Float, y:Float, list:Array<Dynamic>):Void
{
if(wrapper.enabled)
{
        g.setFont(getFont(60));
        g.drawString("" + _CurrentNumberofLives, (15 + (_NumberofLivesActor.getWidth())), 0);
}
});

	}	      	
	
	override public function forwardMessage(msg:String)
	{
		
	}
}