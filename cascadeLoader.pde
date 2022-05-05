// XML Loading Routine
ArrayList doLoadXML(String file){ 
  ArrayList returnList = new ArrayList();

  XML xml = loadXML(file);
  xml = xml.getChild(1);

  String sampleSizeStr = (xml.getChild("size").getContent().trim());//size
  sampleSize = int(split(sampleSizeStr," "));

  XML returnListNode = xml.getChild("stages");//returnList
  int numReturnList = returnListNode.getChildCount();

  for(int i=0;i<numReturnList;i++){//20 returnList in this file
    XML treesNode = returnListNode.getChild(i);
    if (treesNode.getName() == "#text") continue;
    treesNode = treesNode.getChild("trees");
    int numTrees = treesNode.getChildCount();

    ArrayList trees = new ArrayList();// holder of nodes

    for(int j=0;j<numTrees;j++){
      if (treesNode.getChild(j).getName() == "#text") continue;

      int numNodes = treesNode.getChild(j).getChildCount();

      ArrayList nodes = new ArrayList();
      for(int n=0;n<numNodes;n++){
        XML node = treesNode.getChild(j).getChild(n);
        if (node.getName() == "#text" || node.getName() == "#comment") continue;
        XML feature = node.getChild("feature");
        XML rectsNode = feature.getChild("rects");
        int numRects = rectsNode.getChildCount();

        ArrayList<HaarRect> haarRects = new ArrayList<HaarRect>();

        for(int k=0;k<numRects;k++){
          XML kid = rectsNode.getChild(k);
          if (kid.getName() == "#text") {
            continue;
          }

          String[] rStr = split(kid.getContent().trim()," ");

          int[] coords = new int[5];

          for(int l = 0;l<coords.length;l++){
            coords[l] = int(rStr[l]); 
          }

          haarRects.add(new HaarRect(coords));
        }

        boolean tilted = boolean(feature.getChild("tilted").getContent());
        float threshold = float(node.getChild("threshold").getContent().trim());
        float leftVal = 0;
        float rightVal = 0;
        int rightNode = 0;
        int leftNode = 0;
        if (node.getChild("left_val") != null)
          leftVal = float(node.getChild("left_val").getContent().trim());
        if (node.getChild("right_val") != null)
          rightVal = float(node.getChild("right_val").getContent().trim());
        if (node.getChild("right_node") != null)
        rightNode = int(node.getChild("right_node").getContent().trim());
        if (node.getChild("left_node") != null)
        leftNode = int(node.getChild("left_node").getContent().trim());
        nodes.add(new Node(haarRects,tilted,threshold,leftVal,rightVal,leftNode,rightNode));
      }// end nodes loop

      trees.add(new Tree(nodes));

    }//end trees loop
    returnList.add(new Stage(trees));
  }//end returnList loop


  println("");
  println("[cascadeLoader] Total stages: "+returnList.size());
  println("[cascadeLoader] Sample size: "+sampleSize[0] + ", "+sampleSize[1]);
  println("[cascadeLoader] Rows: "+rows+", Columns: "+cols);

  return returnList;
}
