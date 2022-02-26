package  
{
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import flash.geom.Rectangle;
	import flash.events.Event;
	
	public class Mover extends MovieClip
	{
		private var nStartX:Number;
		private var nStartY:Number;
		private var bDragged:Boolean;
		public static const CHANGE_MOVIE:String = "changeMovieFrame"
		
		public function Mover() 
		{
			this.buttonMode = true;
			this.bDragged = false;
			this.nStartX = this.x;
			this.nStartY = this.y;
			this.addEventListener(MouseEvent.MOUSE_DOWN, moveMover);
			this.addEventListener(MouseEvent.CLICK, closeMap);
		}
		private function closeMap(e:MouseEvent):void
		{
			if (TheStage.bIsLittleMapOpen)
			{
				TheStage.bIsLittleMapOpen = false;	
				MovieClip(TheStage.lKotLoader.getChildAt(0)).map_mc.play();//**changes names
			}
		}
		private function moveMover(e:MouseEvent):void
		{
			this.bDragged = true;
			this.startDrag(false,new Rectangle(this.nStartX,this.nStartY,(parent.parent as MovieClip).MaxDrag-this.nStartX, 0));//**check nativ
			stage.addEventListener(MouseEvent.MOUSE_UP, dragChange);
		}
		
		private function dragChange(e:MouseEvent):void
		{
			try
			{
				
				this.bDragged = false;
				(parent.parent as MovieClip).moverX = this.x;//**check nativ
				this.stopDrag();
				dispatchEvent(new Event(CHANGE_MOVIE, true));
				stage.removeEventListener(MouseEvent.MOUSE_UP, dragChange);
			}
			catch(e:TypeError)
			{
				trace("catch in Mover");
			}
		}
		
		public function get dragged():Boolean
		{
			return this.bDragged;
		}
		
		public function get startX():Number
		{
			return this.nStartX;
		}
	}
	
}
