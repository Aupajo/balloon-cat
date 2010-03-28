package particles{
  import events.BalloonCatEvent;
  
  import flash.display.MovieClip;
  import flash.display.Sprite;
  import flash.events.Event;
  import flash.events.MouseEvent;
  
  import org.cove.ape.CircleParticle;
  
  public class BalloonCat extends CircleParticle {
    
    [Embed(source='assets/library.swf', symbol='BalloonCatSprite')]
    private static var BalloonCatSprite:Class;
    
    [Embed(source='assets/library.swf', symbol='Pop')]
    private static var PopClip:Class;
    
    public var graphic:Sprite;
    private var popClip:MovieClip;
    
    public function BalloonCat(x:Number, y:Number, radius:Number, fixed:Boolean = false, mass:Number = 1, elasticity:Number = 0.3, friction:Number = 0) {
      
      graphic = new BalloonCatSprite();
      
      graphic.doubleClickEnabled = true;
      graphic.addEventListener(MouseEvent.CLICK, pop);
      graphic.addEventListener(MouseEvent.MOUSE_DOWN, drag);
      graphic.addEventListener(MouseEvent.MOUSE_MOVE, drag);
      
      var scale:Number = radius * 2 / graphic['body'].width;
      
      graphic.width *= scale;
      graphic.height *= scale;  
      graphic.scaleX *= Math.round(Math.random()) ? 1 : -1;
      setDisplay(graphic);
      
      super(x, y, radius, fixed, mass, elasticity, friction);
      
    }
    
    private function pop(event:MouseEvent):void {
    	if(event.altKey) {
    	   popClip = new PopClip();
    	   popClip.addEventListener(Event.ENTER_FRAME, checkPopClipFrame);
    	
    	   graphic.addChild(popClip);
    	}
    }
    
    private function drag(event:MouseEvent):void {
        var bcEvent:BalloonCatEvent = new BalloonCatEvent('drag', this, { mouseEvent: event });
        graphic.dispatchEvent(bcEvent);
    }
    
    private function checkPopClipFrame(event:Event):void {
    	if(popClip.currentFrame == popClip.totalFrames) {
            var bcEvent:BalloonCatEvent = new BalloonCatEvent('popped', this);
    		graphic.dispatchEvent(bcEvent);
    	}
    }

  }
}