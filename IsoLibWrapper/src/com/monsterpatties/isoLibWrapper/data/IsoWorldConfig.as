package com.monsterpatties.isoLibWrapper.data 
{
	/**
	 * ...
	 * @author monsterpatties
	 */
	public class IsoWorldConfig 
	{		
		/**
		 *
		 * isoViewWidth  - the actual width of the isoWorld
		 * isoViewHeight -  the actual height of the isoWorld
		 * isoGridWidth  - the actual width of the isoWorld in terms of grid size ( x ) ( rows ) note: this should be same with isoGridLength
		 * isoGridLength - the actual length of the isoWorld in terms of grid size ( y )( cols ) note: this should be same with isoGridWidth
		 * isoGridHeight - the actual height of the isoWorld in terms of grid size ( z ) ( z order depth )
		 * isoGridCellSize - the actual size per grid cell
		 * isoViewCenterX - the center x point of the isoWorld
		 * isoViewCenterY - the center y point of the isoWorld
		 */
		
		// 800,600,8,8,0,50,200,200 		
		public static const ISO_VIEW_WIDTH:int = 800;
		public static const ISO_VIEW_HEIGHT:int = 600;
		public static const ISO_GRID_WIDTH:int = 8;
		public static const ISO_GRID_LENGTH:int = 8;
		public static const ISO_GRID_HEIGHT:int = 0;
		public static const ISO_GRID_CELL_SIZE:int = 50;
		public static const ISO_VIEW_CENTER_X:int = 150;
		public static const ISO_VIEW_CENTER_Y:int = 150;		
	}

}