//
//  ViewController.swift
//  Poke3D
//
//  Created by Berkay Kuzu on 29.08.2022.
//

import UIKit
import SceneKit
import ARKit

class ViewController: UIViewController, ARSCNViewDelegate {
    
    @IBOutlet var sceneView: ARSCNView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set the view's delegate
        sceneView.delegate = self
        
        // Show statistics such as fps and timing information
        sceneView.showsStatistics = true
        
        sceneView.autoenablesDefaultLighting = true
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Create a session configuration
        let configuration = ARImageTrackingConfiguration()
        
        if let imageToTrack = ARReferenceImage.referenceImages(inGroupNamed: "Pokemon Cards", bundle: Bundle.main) { // if we have cards, do this! if let is a safe area.
            
            configuration.trackingImages = imageToTrack
            
            configuration.maximumNumberOfTrackedImages = 2
        }
        
        // Run the view's session
        sceneView.session.run(configuration)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Pause the view's session
        sceneView.session.pause()
    }
    
    // MARK: - ARSCNViewDelegate
    
    func renderer(_ renderer: SCNSceneRenderer, nodeFor anchor: ARAnchor) -> SCNNode? {
        
        let node = SCNNode()
        // to set up our plane and render our 3D models.
        
        if let imageAnchor = anchor as? ARImageAnchor {
            
            let plane = SCNPlane(width: imageAnchor.referenceImage.physicalSize.width, height: imageAnchor.referenceImage.physicalSize.height) // It gets the real size of the image detected!
            
            plane.firstMaterial?.diffuse.contents = UIColor(white: 1.0, alpha: 0.5)
            
            let planeNode = SCNNode(geometry: plane)
            
            planeNode.eulerAngles.x = -.pi / 2 // Half a pi is 90 degrees in radians.
            // eulerAngels is node's orientation.
            
            node.addChildNode(planeNode)
            
            if imageAnchor.referenceImage.name == "eeveeCard" {
                
                if let pokeScene = SCNScene(named: "art.scnassets/eevee.scn") { // the image might not be there. Thus, if let should be used.
                    
                    if let pokeNode = pokeScene.rootNode.childNodes.first {
                        
                        pokeNode.eulerAngles.x = .pi / 2 // node's rotation
                        
                        planeNode.addChildNode(pokeNode)
                        
                    } // the image might not be there, so if let should be used.
                    
                } // this will be seen on the top of the plane
            }
        
            if imageAnchor.referenceImage.name == "oddishCard" {
                
                if let pokeScene = SCNScene(named: "art.scnassets/oddish.scn") { // the image might not be there. Thus, if let should be used
                    
                    if let pokeNode = pokeScene.rootNode.childNodes.first {
                        
                        pokeNode.eulerAngles.x = .pi / 2
                        
                        planeNode.addChildNode(pokeNode)
                        
                    } // the image might not be there, so if let should be used.
                    
                } // this will be seen on the top of the plane
            }
            
            
            
        }
        
            
        return node
    }
    
    
    
    
    
    
    
}
