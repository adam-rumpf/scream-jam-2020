/// @desc Initialize tile attributes (all set externally by the level object).

/*
 * Each tile has a specified elevation and image attributes.
 * The tile object, itself, is invisible and has no sprite, but the image attributes are read to determine how the tile is drawn.
 * The elevation is used to define the objective function.
 * Computationally the game is treated as a maximization problem and as a hill climb, and so all heights should be nonnegative integers.
 * In-story and graphically, however, we treat larger height values as representing lower elevations, with the goal of going lower.
 *
 * Note that the tile's x and y attributes indicate its coordinates in the grid, and have nothing to do with where it is displayed.
 */

elevation = 0; // elevation for use in defining the objective function
image_index = 0; // image index of tile sprite
image_xscale = 1; // horizontal mirroring
image_yscale = 1; // vertical mirroring
image_angle = 0; // image rotation
