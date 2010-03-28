package events {
	import flash.events.Event;
	
	import particles.BalloonCat;

	public class BalloonCatEvent extends Event {
		
		private var _balloonCat:BalloonCat;
		private var _properties:Object;
		
		public function BalloonCatEvent(type:String, balloonCat:BalloonCat, properties:Object = null, bubbles:Boolean=false, cancelable:Boolean=false) {
			_balloonCat = balloonCat;
			_properties = properties;
			super(type, bubbles, cancelable);
		}
		
		public function get balloonCat():BalloonCat {
			return _balloonCat;
		}
		
		public function get properties():Object {
			return _properties;
		}
		
	}
}