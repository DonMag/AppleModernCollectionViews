# AppleModernCollectionViews

Modifications to Apple's [Implementing Modern Collection Views](https://developer.apple.com/documentation/uikit/views_and_controls/collection_views/implementing_modern_collection_views) sample app.

Please read the LICENSE file in the source code.

------------------

Edits to `OrthogonalScrollingViewController` to change layout from:

     +-----------------------------------------------------+
     | +---------------------------------+  +-----------+  |
     | |                                 |  |           |  |
     | |                                 |  |           |  |
     | |                                 |  |     1     |  |
     | |                                 |  |           |  |
     | |                                 |  |           |  |
     | |                                 |  +-----------+  |
     | |               0                 |                 |
     | |                                 |  +-----------+  |
     | |                                 |  |           |  |
     | |                                 |  |           |  |
     | |                                 |  |     2     |  |
     | |                                 |  |           |  |
     | |                                 |  |           |  |
     | +---------------------------------+  +-----------+  |
     +-----------------------------------------------------+

to:
	
    +------------------------------+                  These would be off-screen
    | +-------------------------+  |  +-------------------------+  +-------------------------+
    | |            1            |  |  |            4            |  |                         |
    | +-------------------------+  |  +-------------------------+  |                         |
    | +-------------------------+  |  +-------------------------+  |                         |
    | |            2            |  |  |            5            |  |            7            |
    | +-------------------------+  |  +-------------------------+  |                         |
    | +-------------------------+  |  +-------------------------+  |                         |
    | |            3            |  |  |            6            |  |                         |
    | +-------------------------+  |  +-------------------------+  +-------------------------+
    |                              |
    |                              |
    |                              |
    |     rest of the screen       |
    |                              |
    |                              |
    |                              |
    |                              |
    +------------------------------+
	

See StackOverflow question: https://stackoverflow.com/questions/72088824/uicollectionview-compositional-layout-with-orthogonal-scrolling-and-a-different

---------------------

January 2025

Added example showing Orthogonal layout with 1-row / 2-rows / 1- row / 2-rows / etc

    +-----------------------------------------------------+
    | +-------------------+  +-------------------+  +-----|
    | |                   |  |                   |  |     |
    | |                   |  |                   |  |     |
    | |                   |  |                   |  |     |
    | |                   |  |                   |  |     |
    | |                   |  |                   |  |     |
    | |                   |  |                   |  |     |
    | |                   |  |                   |  |     |
    | +-------------------+  +-------------------+  +-----|
    |                                                     |
    | +----------------+  +----------------+  +-----------|
    | |                |  |                |  |           |
    | |                |  |                |  |           |
    | |                |  |                |  |           |
    | |                |  |                |  |           |
    | |                |  |                |  |           |
    | +----------------+  +----------------+  +-----------|
    | +----------------+  +----------------+  +-----------|
    | |                |  |                |  |           |
    | |                |  |                |  |           |
    | |                |  |                |  |           |
    | |                |  |                |  |           |
    | |                |  |                |  |           |
    | +----------------+  +----------------+  +-----------|
    |                                                     |
    | +-------------------+  +-------------------+  +-----|
    | |                   |  |                   |  |     |
    | |                   |  |                   |  |     |
    | |                   |  |                   |  |     |
    | |                   |  |                   |  |     |
    | |                   |  |                   |  |     |
    | |                   |  |                   |  |     |
    | |                   |  |                   |  |     |
    | +-------------------+  +-------------------+  +-----|
    +-----------------------------------------------------+

