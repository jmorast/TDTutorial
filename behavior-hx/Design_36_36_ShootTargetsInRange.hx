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



class Design_36_36_ShootTargetsInRange extends ActorScript
{          	
	
public var _RegionRadius:Float;

public var _Region:Region;

public var _MinDamage:Float;

public var _MaxDamage:Float;

public var _EnemiesinRange:Array<Dynamic>;

public var _SelectionStrategy:Float;

public var _SecondsBetweenShots:Float;

public var _BestTargetSoFar:Actor;
    
/* ========================= Custom Block ========================= */


/* Params are:__Self __Target */
public function _customBlock_shoot_target(__Target:Actor):Void
{
var __Self:Actor = actor;
        trace("" + "----Shooting");
        createRecycledActor(getActorType(12), __Self.getXCenter(), __Self.getYCenter(), Script.FRONT);
        getLastCreatedActor().say("Flying Bullet", "_customBlock_Shoot_Target", [__Target,randomInt(Math.floor(_MinDamage), Math.floor(_MaxDamage))]);
}
    
/* ========================= Custom Block ========================= */


/* Params are: */
public function _customBlock_Random_Target():Actor
{
var __Self:Actor = actor;
        return _EnemiesinRange[Std.int(randomInt(Math.floor(0), Math.floor((_EnemiesinRange.length - 1))))];
}
    
/* ========================= Custom Block ========================= */


/* Params are: */
public function _customBlock_find_target_most_hp():Actor
{
var __Self:Actor = actor;
        _BestTargetSoFar = _EnemiesinRange[Std.int(0)];
propertyChanged("_BestTargetSoFar", _BestTargetSoFar);
        for(item in cast(_EnemiesinRange, Array<Dynamic>))
{
            if((cast((item.say("Health Manager", "_customBlock_GetCurrentHealth")), Float) > cast((_BestTargetSoFar.say("Health Manager", "_customBlock_GetCurrentHealth")), Float)))
{
                _BestTargetSoFar = item;
propertyChanged("_BestTargetSoFar", _BestTargetSoFar);
}

}

        return _BestTargetSoFar;
}
    
/* ========================= Custom Block ========================= */


/* Params are: */
public function _customBlock_find_least_hp():Actor
{
var __Self:Actor = actor;
        _BestTargetSoFar = _EnemiesinRange[Std.int(0)];
propertyChanged("_BestTargetSoFar", _BestTargetSoFar);
        for(item in cast(_EnemiesinRange, Array<Dynamic>))
{
            if((cast((item.say("Health Manager", "_customBlock_GetCurrentHealth")), Float) < cast((_BestTargetSoFar.say("Health Manager", "_customBlock_GetCurrentHealth")), Float)))
{
                _BestTargetSoFar = item;
propertyChanged("_BestTargetSoFar", _BestTargetSoFar);
}

}

        return _BestTargetSoFar;
}
    
/* ========================= Custom Block ========================= */


/* Params are: */
public function _customBlock_find_most_max_hp():Actor
{
var __Self:Actor = actor;
        _BestTargetSoFar = _EnemiesinRange[Std.int(0)];
propertyChanged("_BestTargetSoFar", _BestTargetSoFar);
        for(item in cast(_EnemiesinRange, Array<Dynamic>))
{
            if((cast((item.say("Health Manager", "_customBlock_GetMaxHealth")), Float) > cast((_BestTargetSoFar.say("Health Manager", "_customBlock_GetCurrentHealth")), Float)))
{
                _BestTargetSoFar = item;
propertyChanged("_BestTargetSoFar", _BestTargetSoFar);
}

}

        return _BestTargetSoFar;
}
    
/* ========================= Custom Block ========================= */


/* Params are: */
public function _customBlock_find_least_max_hp():Actor
{
var __Self:Actor = actor;
        _BestTargetSoFar = _EnemiesinRange[Std.int(0)];
propertyChanged("_BestTargetSoFar", _BestTargetSoFar);
        for(item in cast(_EnemiesinRange, Array<Dynamic>))
{
            if((cast((item.say("Health Manager", "_customBlock_GetMaxHealth")), Float) < cast((_BestTargetSoFar.say("Health Manager", "_customBlock_GetCurrentHealth")), Float)))
{
                _BestTargetSoFar = item;
propertyChanged("_BestTargetSoFar", _BestTargetSoFar);
}

}

        return _BestTargetSoFar;
}

 
 	public function new(dummy:Int, actor:Actor, dummy2:Engine)
	{
		super(actor);
		nameMap.set("Region Radius", "_RegionRadius");
_RegionRadius = 0.0;
nameMap.set("Region", "_Region");
nameMap.set("Min Damage", "_MinDamage");
_MinDamage = 0.0;
nameMap.set("Max Damage", "_MaxDamage");
_MaxDamage = 0.0;
nameMap.set("Enemies in Range", "_EnemiesinRange");
_EnemiesinRange = [];
nameMap.set("Selection Strategy", "_SelectionStrategy");
_SelectionStrategy = 0.0;
nameMap.set("Seconds Between Shots", "_SecondsBetweenShots");
_SecondsBetweenShots = 0.0;
nameMap.set("Best Target So Far", "_BestTargetSoFar");
nameMap.set("Actor", "actor");

	}
	
	override public function init()
	{
		    
/* ======================== When Creating ========================= */
        createCircularRegion((actor.getXCenter() - _RegionRadius), (actor.getYCenter() - _RegionRadius), _RegionRadius);
        _Region = getLastCreatedRegion();
propertyChanged("_Region", _Region);
        _EnemiesinRange = new Array<Dynamic>();
propertyChanged("_EnemiesinRange", _EnemiesinRange);
    
/* ======================= Every N seconds ======================== */
runPeriodically(1000 * _SecondsBetweenShots, function(timeTask:TimedTask):Void
{
if(wrapper.enabled)
{
        if((_EnemiesinRange.length == 0))
{
            return;
}

        if((_SelectionStrategy == 0))
{
            actor.say("Shoot Targets In Range", "_customBlock_shoot_target", [cast((actor.say("Shoot Targets In Range", "_customBlock_find_target_most_hp")), Actor)]);
}

        else if((_SelectionStrategy == 1))
{
            actor.say("Shoot Targets In Range", "_customBlock_shoot_target", [cast((actor.say("Shoot Targets In Range", "_customBlock_find_least_hp")), Actor)]);
}

        else if((_SelectionStrategy == 2))
{
            actor.say("Shoot Targets In Range", "_customBlock_shoot_target", [cast((actor.say("Shoot Targets In Range", "_customBlock_find_most_max_hp")), Actor)]);
}

        else if((_SelectionStrategy == 3))
{
            actor.say("Shoot Targets In Range", "_customBlock_shoot_target", [cast((actor.say("Shoot Targets In Range", "_customBlock_find_least_max_hp")), Actor)]);
}

        else if((_SelectionStrategy == 4))
{
            actor.say("Shoot Targets In Range", "_customBlock_shoot_target", [cast((actor.say("Shoot Targets In Range", "_customBlock_Random_Target")), Actor)]);
}

}
}, actor);
    
/* ======================= Member of Group ======================== */
addWhenTypeGroupKilledListener(getActorGroup(5), function(eventActor:Actor, list:Array<Dynamic>):Void
{
if(wrapper.enabled)
{
        _EnemiesinRange.remove(eventActor);
}
});
    
/* ======================= Member of Group ======================== */
addActorEntersRegionListener(_Region, function(a:Actor, list:Array<Dynamic>):Void
{
if(wrapper.enabled && sameAsAny(getActorGroup(5),a.getType(),a.getGroup()))
{
        _EnemiesinRange.push(a);
}
});
    
/* ======================= Member of Group ======================== */
addActorExitsRegionListener(_Region, function(a:Actor, list:Array<Dynamic>):Void
{
if(wrapper.enabled && sameAsAny(getActorGroup(5),a.getType(),a.getGroup()))
{
        _EnemiesinRange.remove(a);
}
});

	}	      	
	
	override public function forwardMessage(msg:String)
	{
		
	}
}