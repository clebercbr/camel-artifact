/* Initial goals */
!start.
!listen("ArtifactA").

//!listen("Artifact0").
//!listen("Artifact1").
//!listen("Artifact2").
//!listen("Artifact3").
//!listen("Artifact4").
//!listen("Artifact5").
//!listen("Artifact6").
//!listen("Artifact7").
//!listen("Artifact8").
//!listen("Artifact9").

!listen("ArtifactC").

+!start: true <-
	.print("Building artifacts..."); 
	makeArtifact("ArtifactB","artifacts.ArtifactB",[],ArtifactBid);
	makeArtifact("ArtifactC","camelartifacts.ArtifactC",[],ArtifactCid);
	.print("Linking artifacts..."); 
	linkArtifacts(ArtifactCid,"out-1",ArtifactBid);
	linkArtifacts(ArtifactBid,"out-2",ArtifactCid);

     for ( .range(I,0,9) ) {
        .concat("Artifact",I,X);
        makeArtifact(X,"artifacts.ArtifactB",[],Artid0);
		linkArtifacts(ArtifactCid,"out-1",Artid0);
		linkArtifacts(Artid0,"out-2",ArtifactCid);        
     }
     
	//makeArtifact("Artifact0","artifacts.ArtifactB",[],Artifactid0);
	//makeArtifact("Artifact1","artifacts.ArtifactB",[],Artifactid1);
	//makeArtifact("Artifact2","artifacts.ArtifactB",[],Artifactid2);
	//makeArtifact("Artifact3","artifacts.ArtifactB",[],Artifactid3);
	//makeArtifact("Artifact4","artifacts.ArtifactB",[],Artifactid4);
	//makeArtifact("Artifact5","artifacts.ArtifactB",[],Artifactid5);
	//makeArtifact("Artifact6","artifacts.ArtifactB",[],Artifactid6);
	//makeArtifact("Artifact7","artifacts.ArtifactB",[],Artifactid7);
	//makeArtifact("Artifact8","artifacts.ArtifactB",[],Artifactid8);
	//makeArtifact("Artifact9","artifacts.ArtifactB",[],Artifactid9);
	//linkArtifacts(ArtifactCid,"out-1",Artifactid0);
	//linkArtifacts(Artifactid0,"out-2",ArtifactCid);
	//linkArtifacts(ArtifactCid,"out-1",Artifactid1);
	//linkArtifacts(Artifactid1,"out-2",ArtifactCid);
	//linkArtifacts(ArtifactCid,"out-1",Artifactid2);
	//linkArtifacts(Artifactid2,"out-2",ArtifactCid);
	//linkArtifacts(ArtifactCid,"out-1",Artifactid3);
	//linkArtifacts(Artifactid3,"out-2",ArtifactCid);
	//linkArtifacts(ArtifactCid,"out-1",Artifactid4);
	//linkArtifacts(Artifactid4,"out-2",ArtifactCid);
	//linkArtifacts(ArtifactCid,"out-1",Artifactid5);
	//linkArtifacts(Artifactid5,"out-2",ArtifactCid);
	//linkArtifacts(ArtifactCid,"out-1",Artifactid6);
	//linkArtifacts(Artifactid6,"out-2",ArtifactCid);
	//linkArtifacts(ArtifactCid,"out-1",Artifactid7);
	//linkArtifacts(Artifactid7,"out-2",ArtifactCid);
	//linkArtifacts(ArtifactCid,"out-1",Artifactid8);
	//linkArtifacts(Artifactid8,"out-2",ArtifactCid);
	//linkArtifacts(ArtifactCid,"out-1",Artifactid9);
	//linkArtifacts(Artifactid9,"out-2",ArtifactCid);

	makeArtifact("ArtifactA","camelartifacts.ArtifactA",[],ArtifactAid);
	//makeArtifact("Artifact0","camelartifacts.ArtifactA",[],Artifactid0);
	//makeArtifact("Artifact1","camelartifacts.ArtifactA",[],Artifactid1);
	//makeArtifact("Artifact2","camelartifacts.ArtifactA",[],Artifactid2);
	//makeArtifact("Artifact3","camelartifacts.ArtifactA",[],Artifactid3);
	//makeArtifact("Artifact4","camelartifacts.ArtifactA",[],Artifactid4);
	//makeArtifact("Artifact5","camelartifacts.ArtifactA",[],Artifactid5);
	//makeArtifact("Artifact6","camelartifacts.ArtifactA",[],Artifactid6);
	//makeArtifact("Artifact7","camelartifacts.ArtifactA",[],Artifactid7);
	//makeArtifact("Artifact8","camelartifacts.ArtifactA",[],Artifactid8);
	//makeArtifact("Artifact9","camelartifacts.ArtifactA",[],Artifactid9);

	.print("Artifact are ready for use!");
	!!sendKAmsg("ArtifactA");

	!!sendKAmsg("Artifact0");
	!!sendKAmsg("Artifact1");
	!!sendKAmsg("Artifact2");
	!!sendKAmsg("Artifact3");
	!!sendKAmsg("Artifact4");
	!!sendKAmsg("Artifact5");
	!!sendKAmsg("Artifact6");
	!!sendKAmsg("Artifact7");
	!!sendKAmsg("Artifact8");
	!!sendKAmsg("Artifact9");

	!!sendKAmsg("ArtifactB");
	!!sendKAmsg("ArtifactC").
	
+!listen(Art): true <-
	focusWhenAvailable(Art); //Just to make sure the artifact was already created
	.print("Start listening on ",Art,"..."); 
	lookupArtifact(Art,Aid);
	focus(Aid);
	listenRoutes(true)[artifact_id(Aid)]; //Start listening on artifact (blocking command)
	.print("Listening process on ",Art," finished!").

+!sendKAmsg(Art): true <- 
	focusWhenAvailable(Art); //Just to make sure the artifact was already created
	lookupArtifact(Art,Aid);
	.print("Sending keepalive message to ",Art,"!");
	focus(Aid);
	sendKA[artifact_id(Aid)];
	.wait(2000);
	!!sendKAmsg(Art).

{ include("$jacamoJar/templates/common-cartago.asl") }
{ include("$jacamoJar/templates/common-moise.asl") }
