/// @desc Initialize tile attributes (all set externally by the level object).

/*
 * Each tile has a specified height and image attributes.
 * The tile object, itself, is invisible, but these attributes can be accessed to draw the tiles.
 * The height is used to define the objective function.
 * Computationally the game is treated as a maximization problem and as a hill climb problem, and so all heights should be nonnegative integers.
 * In-story and graphically, however, we treat larger height values as representing lower elevations, with the goal of going lower.
 *
 * Note that the tile's x and y attributes indicate its coordinates in the grid, and have nothing to do with where it is displayed.
 */

height = 0; // elevation for use in defining the objective function
image_index = 0; // image index of tile sprite
hmirror = false; // whether to horizontally mirror the image
vmirror = false; // whether to vertically mirror the image
rotate = 0; // increment of 90 degrees by which to rotate the image
