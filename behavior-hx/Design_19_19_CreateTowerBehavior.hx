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



class Design_19_19_CreateTowerBehavior extends ActorScript
{          	
	
public var _Button1:ActorType;

public var _Button2:ActorType;

public var _Button3:ActorType;

public var _b1:Actor;

public var _b2:Actor;

public var _b3:Actor;

public var _Button1ClickedEvent:String;

public var _Button2ClickedEvent:String;

public var _Button3ClickedEvent:String;

public var _AnimationDuragion:Float;

public var _ButtonsVisable:Bool;
    
/* ========================= Custom Event ========================= */
public function _customEvent_create_blue():Void
{
        createRecycledActor(getActorType(2), actor.getX(), actor.getY(), Script.FRONT);
        recycleActor(actor);
}

    
/* ========================= Custom Block ========================= */


/* Params are:__Self */
public function _customBlock_show_buttons():Void
{
var __Self:Actor = actor;
        if(_ButtonsVisable)
{
            return;
}

        _ButtonsVisable = true;
propertyChanged("_ButtonsVisable", _ButtonsVisable);
        _b1.enableActorDrawing();
        _b1.moveBy(-50, -50, _AnimationDuragion, Quad.easeIn);
        _b2.enableActorDrawing();
        _b2.moveBy(-100, -100, _AnimationDuragion, Quad.easeIn);
        _b3.enableActorDrawing();
        _b3.moveBy(50, 50, _AnimationDuragion, Quad.easeIn);
}
    
/* ========================= Custom Block ========================= */


/* Params are:__Self */
public function _customBlock_hide_buttons():Void
{
var __Self:Actor = actor;
        if(!(_ButtonsVisable))
{
            return;
}

        _ButtonsVisable = false;
propertyChanged("_ButtonsVisable", _ButtonsVisable);
        _b1.moveTo(actor.getX(), actor.getY(), _AnimationDuragion, Back.easeIn);
        _b2.moveTo(actor.getX(), actor.getY(), _AnimationDuragion, Back.easeIn);
        _b3.moveTo(actor.getX(), actor.getY(), _AnimationDuragion, Back.easeIn);
        runLater(1000 * _AnimationDuragion, function(timeTask:TimedTask):Void {
                    _b1.disableActorDrawing();
                    _b2.disableActorDrawing();
                    _b3.disableActorDrawing();
}, actor);
}

 
 	public function new(dummy:Int, actor:Actor, dummy2:Engine)
	{
		super(actor);
		nameMap.set("Button 1", "_Button1");
nameMap.set("Button 2", "_Button2");
nameMap.set("Button 3", "_Button3");
nameMap.set("b1", "_b1");
nameMap.set("b2", "_b2");
nameMap.set("b3", "_b3");
nameMap.set("Button 1 Clicked Event", "_Button1ClickedEvent");
_Button1ClickedEvent = "";
nameMap.set("Button 2 Clicked Event", "_Button2ClickedEvent");
_Button2ClickedEvent = "";
nameMap.set("Button 3 Clicked Event", "_Button3ClickedEvent");
_Button3ClickedEvent = "";
nameMap.set("Animation Duragion", "_AnimationDuragion");
_AnimationDuragion = 0.0;
nameMap.set("Buttons Visable?", "_ButtonsVisable");
_ButtonsVisable = false;
nameMap.set("Actor", "actor");

	}
	
	override public function init()
	{
		    
/* ======================== When Creating ========================= */
        createRecycledActor(_Button1, actor.getX(), actor.getY(), Script.FRONT);
        _b1 = getLastCreatedActor();
propertyChanged("_b1", _b1);
        _b1.disableActorDrawing();
        createRecycledActor(_Button2, actor.getX(), actor.getY(), Script.FRONT);
        _b2 = getLastCreatedActor();
propertyChanged("_b2", _b2);
        _b2.disableActorDrawing();
        createRecycledActor(_Button3, actor.getX(), actor.getY(), Script.FRONT);
        _b3 = getLastCreatedActor();
propertyChanged("_b3", _b3);
        _b3.disableActorDrawing();
    
/* ============================ Click ============================= */
addMousePressedListener(function(list:Array<Dynamic>):Void
{
if(wrapper.enabled)
{
        if(actor.isMousePressed())
{
            actor.say("Create Tower Behavior", "_customBlock_show_buttons");
}

        else
{
            actor.say("Create Tower Behavior", "_customBlock_hide_buttons");
            if(_b1.isMouseDown())
{
                runLater(1000 * _AnimationDuragion, function(timeTask:TimedTask):Void {
                            actor.shout("_customEvent_" + _Button1ClickedEvent);
}, actor);
}

            else if(_b2.isMouseDown())
{
                runLater(1000 * _AnimationDuragion, function(timeTask:TimedTask):Void {
                            actor.shout("_customEvent_" + _Button1ClickedEvent);
}, actor);
}

            else if(_b3.isMouseDown())
{
                runLater(1000 * _AnimationDuragion, function(timeTask:TimedTask):Void {
                            actor.shout("_customEvent_" + _Button1ClickedEvent);
}, actor);
}

}

}
});
    
/* ======================== Specific Actor ======================== */
addWhenKilledListener(actor, function(list:Array<Dynamic>):Void
{
if(wrapper.enabled)
{
        recycleActor(_b1);
        recycleActor(_b2);
        recycleActor(_b3);
}
});

	}	      	
	
	override public function forwardMessage(msg:String)
	{
		
	}
}