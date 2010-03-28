package {
  import events.*;
  
  import flash.display.*;
  import flash.events.Event;
  import flash.events.MouseEvent;
  import flash.text.TextField;
  
  import org.cove.ape.*;
  
  import particles.*;
  
  [SWF(width='600', height='400', backgroundColor='#D1E6FA')]
  
  public class BalloonCatGame extends Sprite {
  	
  	private static const LOGGING_ENABLED:Boolean = false;
    
    [Embed(source='assets/library.swf', symbol='BreedButton')]
    private static var BreedButton:Class;
    
    [Embed(source='assets/library.swf', symbol='Background')]
    private static var Background:Class;
    
    private var lift:Vector;
    private var wind:Vector;
    private var balloons:Group;
    private var boundaries:Group;
    private var textField:TextField;
    
    public function BalloonCatGame() {
      var background:Sprite = new Background();
      addChild(background);
      
      var playPen:Sprite = new Sprite();
      addChild(playPen);
      
      // Start engine
      APEngine.init(1/4);
      APEngine.container = playPen;
      APEngine.container.stage.frameRate = 30;
      
      addEventListener(Event.ENTER_FRAME, run);
      addEventListener(Event.ADDED_TO_STAGE, ready);
      
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
      
      // Add logger
      if(LOGGING_ENABLED) {
        textField = new TextField();
         addChild(textField);
      
        log('Ready.');
      }
    }
    
    private function run(event:Event):void {
      APEngine.step();
      APEngine.paint();
    }
    
    private function ready(event:Event):void {
      createBoundaries();
      
      var button:SimpleButton = new BreedButton();
      button.addEventListener(MouseEvent.CLICK, breedButtonClicked);
      
      // Bottom left
      button.x = button.width / 2 + 10;
      button.y = height - button.height - 40;
      
      addChild(button);
      
      // Add 10 balloons
      addBalloons(10);
    }
    
    private function breedButtonClicked(event:Event):void {
    	addBalloons(1);
    }
    
    private function createBoundaries():void {
      
      var top:RectangleParticle = new RectangleParticle(300, -11, 600, 20, 0, true);
      var bottom:RectangleParticle = new RectangleParticle(300, 410, 600, 20, 0, true);
      var left:RectangleParticle = new RectangleParticle(-11, 200, 20, 400, 0, true);
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
        balloon.graphic.addEventListener('popped', removeBalloon);
        balloon.graphic.addEventListener('drag', dragBalloon);
        
        balloons.addParticle(balloon);
      }
    }
    
    private function dragBalloon(event:BalloonCatEvent):void {
    	if(event.properties.mouseEvent.buttonDown) {
            event.balloonCat.px = event.properties.mouseEvent.stageX;
            event.balloonCat.py = event.properties.mouseEvent.stageY;
        }
    }
    
    private function removeBalloon(event:BalloonCatEvent):void {
        balloons.removeParticle(event.balloonCat);
    }
    
    private function log(message:String):void {
    	if(LOGGING_ENABLED)
    	   textField.appendText(message + "\n");
    }
    
  }
}
