package stone.core;

import stone.core.InputAbstract;
import stone.core.GraphicsAbstract;

class Game {
	var current_scene:Scene;

	public var graphics(default, null):GraphicsAbstract;
	public var input(default, null):InputAbstract;

	public function new(scene_constructor:Game->Scene, graphics:GraphicsAbstract, input:InputAbstract) {
		this.graphics = graphics;
		this.input = input;
		scene_init(scene_constructor);
	}

	public function update(elapsed_seconds:Float) {
		input.update_mouse_position();
		input.raise_mouse_button_events();
		input.raise_keyboard_button_events();
		current_scene.update(elapsed_seconds);
	}

	function scene_init(scene_constructor:Game->Scene) {
		current_scene = scene_constructor(this);
		current_scene.init();
	}

	public function scene_change(scene_constructor:Game->Scene) {
		if (current_scene != null) {
			graphics.close();
			current_scene.close();
			scene_init(scene_constructor);
		}
	}

	public function draw() {
		current_scene.draw();
		graphics.draw();
	}
}

abstract class Scene {
	var game:Game;
	var bounds:RectangleGeometry;

	public var color(default, null):RGBA;

	public function new(game:Game, bounds:RectangleGeometry, color:RGBA) {
		this.game = game;
		this.bounds = bounds;
		this.color = color;
	}

	/**
		Handle scene initiliasation here, e.g. set up level, player, etc.
	**/
	abstract public function init():Void;

	/**
		Handle game logic here, e,g, calculating movement for player, change object states, etc.
		@param elapsed_seconds is the amount of seconds that have passed since the last frame
	**/
	abstract public function update(elapsed_seconds:Float):Void;

	/**
		Make draw calls here
	**/
	abstract public function draw():Void;

	/**
		Clean up the scene here, e.g. remove graphics buffers
	**/
	abstract public function close():Void;
}

@:structInit
class RectangleGeometry {
	public var x:Int = 0;
	public var y:Int = 0;
	public var width:Int;
	public var height:Int;
}
