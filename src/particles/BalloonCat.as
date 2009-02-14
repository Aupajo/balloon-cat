package particles{
  import flash.display.Sprite;
  
  import org.cove.ape.CircleParticle;
  
  public class BalloonCat extends CircleParticle {
    
    [Embed(source='assets/library.swf', symbol='BalloonCatSprite')]
    private static var BalloonCatSprite:Class;
    
    public function BalloonCat(x:Number, y:Number, radius:Number, fixed:Boolean = false, mass:Number = 1, elasticity:Number = 0.3, friction:Number = 0) {
      
      var graphic:Sprite = new BalloonCatSprite();
      var scale:Number = radius * 2 / graphic['body'].width;
      
      graphic.width *= scale;
      graphic.height *= scale;  
      graphic.scaleX *= Math.round(Math.random()) ? 1 : -1;
      setDisplay(graphic);
      
      super(x, y, radius, fixed, mass, elasticity, friction);
      
    }

  }
}