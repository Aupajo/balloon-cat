package {
  import flash.display.*;
  import flash.events.Event;
  
  import org.cove.ape.*;
  
  [SWF(width='600', height='400')]
  public class BalloonCatGame extends Sprite {
    private var lift:Vector;
    private var wind:Vector;
    private var balloons:Group;
    private var boundaries:Group;
    
    public function BalloonCatGame() {
      
      // Start engine
      APEngine.init();
      APEngine.container = this;
      APEngine.container.stage.frameRate = 50;
      
      addEventListener(Event.ENTER_FRAME, run);
      addEventListener(Event.ADDED_TO_STAGE, populate);
      
      // Forces
      lift = new Vector(0, -1);
      wind = new Vector(0, 0);
      
      APEngine.addForce(lift);
      APEngine.addForce(wind);
      
      // Groups
      balloons = new Group();
      balloons.collideInternal = true;
      boundaries = new Group();
      
      balloons.addCollidable(boundaries);
      
      APEngine.addGroup(balloons);
      APEngine.addGroup(boundaries);
      
    }
    
    private function run(event:Event):void {
      APEngine.step();
      APEngine.paint();
    }
    
    private function populate(event:Event):void {
      createBoundaries();
      addBalloons(10);
    }
    
    private function createBoundaries():void {
      
      var top:RectangleParticle = new RectangleParticle(300, -10, 600, 20, 0, true);
      var bottom:RectangleParticle = new RectangleParticle(300, 410, 600, 20, 0, true);
      var left:RectangleParticle = new RectangleParticle(-10, 200, 20, 400, 0, true);
      var right:RectangleParticle = new RectangleParticle(610, 200, 20, 400, 0, true);
      
      boundaries.addParticle(top);
      boundaries.addParticle(bottom);
      boundaries.addParticle(left);
      boundaries.addParticle(right);
    }
    
    private function addBalloons(numBalloons:uint):void {
      
      var minSize:Number = 10;
      var maxSize:Number = 20;
      
      for(var i:uint = 0; i < numBalloons; i ++) {
        var radius:Number = Math.random() * (maxSize - minSize) + minSize;
        var balloon:CircleParticle = new CircleParticle(Math.random() * 500 + 50 - radius, 300, radius, false, maxSize / radius);
        balloons.addParticle(balloon);
      }
      
    }
    
  }
}
