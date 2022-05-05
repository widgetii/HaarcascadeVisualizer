import java.util.*;

class Node {
  ArrayList<HaarRect> haarRects;
  boolean tilted;
  float leftVal, rightVal, threshold;
  int leftNode, rightNode;


  Node(ArrayList haarRects, boolean tilted, float threshold, float leftVal, float rightVal, int leftNode, int rightNode) {
    this.haarRects = haarRects;
    this.threshold = threshold;
    this.tilted = tilted;
    this.leftVal = leftVal;
    this.rightVal = rightVal;
    this.leftNode = leftNode;
    this.rightNode = rightNode;
  }

  Rectangle[] getRectangles() {
    Rectangle[] rects = new Rectangle[haarRects.size()];
    for (int i=0;i<haarRects.size();i++) {
      HaarRect r = haarRects.get(i);
      rects[i] = new Rectangle(r.dx, r.dy, r.dw, r.dh);
    }
    return rects;
  }

  HaarRect[] getHaarRectangles() {
    HaarRect[] rects = new HaarRect[haarRects.size()];
     for (int i=0;i<haarRects.size();i++) {
      rects[i] = haarRects.get(i);
    }
    return rects;
  }

  HaarRect[] getHaarRectanglesSorted() {
    HaarRect[] sorted = getHaarRectangles();
    Arrays.sort(sorted, new HaarRectSizeComparator());
    return sorted;
  }
}
