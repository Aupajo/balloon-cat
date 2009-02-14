package {
  import flash.display.*;
  import flash.events.Event;
  
  import org.cove.ape.*;
  
  [SWF(width='600', height='400')]
  public class BalloonCatGame extends Sprite {
    private var gravity:Vector;
    private var wind:Vector;
    private var collidable:Group;
    
    public function BalloonCatGame() {
      
      // Start engine
      APEngine.init();
      APEngine.container = this;
      APEngine.container.stage.frameRate = 50;
      
      addEventListener(Event.ENTER_FRAME, run);
      addEventListener(Event.ADDED_TO_STAGE, populate);
      
      // Forces
      gravity = new Vector(0, -1);
      wind = new Vector(0.05, 0);
      
      APEngine.addForce(gravity);
      APEngine.addForce(wind);
      
      // Groups
      collidable = new Group();
      collidable.collideInternal = true;
      APEngine.addGroup(collidable);
      
    }
    
    private function run(event:Event):void {
      APEngine.step();
      APEngine.paint();
    }
    
    private function populate(event:Event):void {
      var rect:RectangleParticle = new RectangleParticle(0, 0, stage.stageWidth, 20, 0, true);
      collidable.addParticle(rect);
      
      var minSize:Number = 5;
      var maxSize:Number = 20;
      
      for(var i:uint = 0; i < 20; i ++) {
        var radius:Number = Math.random() * (maxSize - minSize) + minSize;
        var balloon:CircleParticle = new CircleParticle(Math.random() * 800, 300, radius, false, maxSize / radius);
        collidable.addParticle(balloon);
      }
    }
    
  }
}
