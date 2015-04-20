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



class Design_38_38_NumberofWavesManager extends SceneScript
{
	
public var _MaxWaves:Float;

public var _NumberofWaves:Float;

public var _ActiveSpanwers:Float;

public var _ActiveEnemies:Float;

public var _GoButton:Actor;

public var _EnemySpawners:Array<Dynamic>;

public var _CurrentWave:Float;
    
/* ========================= Custom Event ========================= */
public function _customEvent_spawner_started():Void
{
        _ActiveSpanwers += 1;
propertyChanged("_ActiveSpanwers", _ActiveSpanwers);
}

    
/* ========================= Custom Event ========================= */
public function _customEvent_spawner_finished():Void
{
        _ActiveSpanwers -= 1;
propertyChanged("_ActiveSpanwers", _ActiveSpanwers);
        if((!(_CurrentWave == _MaxWaves) && (_ActiveSpanwers == 0)))
{
            _GoButton.enableActorDrawing();
}

}

    
/* ========================= Custom Event ========================= */
public function _customEvent_start_next_wave():Void
{
        if((_CurrentWave == _MaxWaves))
{
            return;
}

        if(!(_ActiveSpanwers == 0))
{
            return;
}

        _CurrentWave += 1;
propertyChanged("_CurrentWave", _CurrentWave);
        _GoButton.disableActorDrawing();
        for(actorOfType in getActorsOfType(getActorType(29)))
{
if(actorOfType != null && !actorOfType.dead && !actorOfType.recycled){
            actorOfType.say("Spawn Enemies", "_customBlock_Start_Wave");
}
}

}

    
/* ========================= Custom Event ========================= */
public function _customEvent_enemy_spawned():Void
{
        _ActiveEnemies += 1;
propertyChanged("_ActiveEnemies", _ActiveEnemies);
}


 
 	public function new(dummy:Int, dummy2:Engine)
	{
		super();
		nameMap.set("Max Waves", "_MaxWaves");
_MaxWaves = 0.0;
nameMap.set("Number of Waves", "_NumberofWaves");
_NumberofWaves = 0.0;
nameMap.set("Active Spanwers", "_ActiveSpanwers");
_ActiveSpanwers = 0.0;
nameMap.set("Active Enemies", "_ActiveEnemies");
_ActiveEnemies = 0.0;
nameMap.set("Go Button", "_GoButton");
nameMap.set("Enemy Spawners", "_EnemySpawners");
_EnemySpawners = [];
nameMap.set("Current Wave", "_CurrentWave");
_CurrentWave = 0.0;

	}
	
	override public function init()
	{
		    
/* ======================== When Creating ========================= */
        createRecycledActor(getActorType(72), 300, 10, Script.FRONT);
        createRecycledActor(getActorType(78), 340, 40, Script.FRONT);
        _GoButton = getLastCreatedActor();
propertyChanged("_GoButton", _GoButton);
        _GoButton.setAnimation("" + ("" + "Active"));
        _EnemySpawners = new Array<Dynamic>();
propertyChanged("_EnemySpawners", _EnemySpawners);
    
/* ======================= Member of Group ======================== */
addWhenTypeGroupKilledListener(getActorGroup(5), function(eventActor:Actor, list:Array<Dynamic>):Void
{
if(wrapper.enabled)
{
        _ActiveEnemies -= 1;
propertyChanged("_ActiveEnemies", _ActiveEnemies);
        if(((_ActiveEnemies == 0) && (_ActiveSpanwers == 0)))
{
            if((_CurrentWave == _MaxWaves))
{
                shoutToScene("_customEvent_" + "no_more_enemies");
}

            else
{
                shoutToScene("_customEvent_" + "start_next_wave");
}

}

}
});
    
/* ========================= When Drawing ========================= */
addWhenDrawingListener(null, function(g:G, x:Float, y:Float, list:Array<Dynamic>):Void
{
if(wrapper.enabled)
{
        g.setFont(getFont(76));
        g.drawString("" + (("" + _CurrentWave) + (("" + "/") + ("" + _MaxWaves))), 325, 0);
}
});
    
/* ======================== When Updating ========================= */
addWhenUpdatedListener(null, function(elapsedTime:Float, list:Array<Dynamic>):Void
{
if(wrapper.enabled)
{
        if((_EnemySpawners.length == 0))
{
            for(actorOfType in getActorsOfType(getActorType(29)))
{
if(actorOfType != null && !actorOfType.dead && !actorOfType.recycled){
                _EnemySpawners.push(actorOfType);
                _MaxWaves = asNumber(Math.max(_MaxWaves, cast((actorOfType.say("Spawn Enemies", "_customBlock_number_of_waves")), Float)));
propertyChanged("_MaxWaves", _MaxWaves);
}
}

}

}
});
    
/* =========================== On Actor =========================== */
addMouseOverActorListener(_GoButton, function(mouseState:Int, list:Array<Dynamic>):Void
{
if(wrapper.enabled && 5 == mouseState)
{
        shoutToScene("_customEvent_" + "start_next_wave");
}
});

	}	      	
	
	override public function forwardMessage(msg:String)
	{
		
	}
}