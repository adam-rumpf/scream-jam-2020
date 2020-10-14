/// @desc Initialize tile attributes (all set externally by the level object).

/*
 * Each tile has a specified height and image.
 * The height is used to define the objective function.
 * Computationally the game is treated as a maximization problem and as a hill climb problem, and so all heights should be nonnegative integers.
 * In-story and graphically, however, we treat larger height values as representing lower elevations, with the goal of going lower.
 */

height = 0; // elevation for use in defining the objective function
image_index = 0;
image_speed = 0;
