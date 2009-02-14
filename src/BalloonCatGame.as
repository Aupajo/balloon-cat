package {
  import particles.*;
  import flash.display.*;
  import flash.events.Event;
  import org.cove.ape.*;
  
  [SWF(width='600', height='400', backgroundColor='#CCCCCC')]
  
  public class BalloonCatGame extends Sprite {
    
    private var lift:Vector;
    private var wind:Vector;
    private var balloons:Group;
    private var boundaries:Group;
    
    public function BalloonCatGame() {
      
      // Start engine
      APEngine.init(1/4);
      APEngine.container = this;
      APEngine.container.stage.frameRate = 30;
      
      addEventListener(Event.ENTER_FRAME, run);
      addEventListener(Event.ADDED_TO_STAGE, populate);
      
      // Forces
      lift = new Vector(0, -1);
      wind = new Vector(0.01, 0);
      
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
      addBalloons(100);
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
    
    private function addBalloons(numBalloons:uint, minSize:uint = 20, maxSize:uint = 40):void {
      for(var i:uint = 0; i < numBalloons; i ++) {
        var radius:Number = Math.random() * (maxSize - minSize) + minSize;
        var balloon:BalloonCat = new BalloonCat(Math.random() * 500 + 50 - radius, 400, radius, false, maxSize / radius);
        balloons.addParticle(balloon);
      }
      
    }
    
  }
}
