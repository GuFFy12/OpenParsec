//import SwiftUI
//import GLKit
//
//struct ParsecGLKViewController:UIViewControllerRepresentable
//{
//	let glkView = GLKView()
//	let glkViewController = GLKViewController()
//	let onBeforeRender:() -> Void
//
//	func makeCoordinator() -> ParsecGLKRenderer
//	{
//		ParsecGLKRenderer(glkView, glkViewController, onBeforeRender)
//	}
//
//	func makeUIViewController(context:UIViewControllerRepresentableContext<ParsecGLKViewController>) -> GLKViewController
//	{
//		glkView.context = EAGLContext(api:.openGLES3)!
//		glkViewController.view = glkView
//		glkViewController.preferredFramesPerSecond = 60
//		return glkViewController
//	}
//
//	func updateUIViewController(_ uiViewController:GLKViewController, context:UIViewControllerRepresentableContext<ParsecGLKViewController>) { }
//}

import GLKit

class ParsecGLKViewController : ParsecPlayground {

	var glkView: GLKView!
	let glkViewController = GLKViewController()
	var glkRenderer: ParsecGLKRenderer!
	let updateImage:() -> Void
	
	let viewController: UIViewController
	
	required init(viewController: UIViewController, updateImage: @escaping () -> Void) {
		self.viewController = viewController
		self.updateImage = updateImage
	}

	public func viewDidLoad() {
		glkView = GLKView(frame: .zero)
		glkRenderer = ParsecGLKRenderer(glkView, glkViewController, updateImage)
		self.viewController.view.addSubview(glkView)
		setupGLKViewController()
		

	}

	private func setupGLKViewController() {
		glkView.context = EAGLContext(api: .openGLES3)!
		glkViewController.view = glkView
		glkViewController.preferredFramesPerSecond = 60
		self.viewController.addChild(glkViewController)
		self.viewController.view.addSubview(glkViewController.view)
		glkViewController.view.translatesAutoresizingMaskIntoConstraints = false
		NSLayoutConstraint.activate([
			glkViewController.view.leadingAnchor.constraint(equalTo: self.viewController.view.leadingAnchor),
			glkViewController.view.trailingAnchor.constraint(equalTo: self.viewController.view.trailingAnchor),
			glkViewController.view.topAnchor.constraint(equalTo: self.viewController.view.topAnchor),
			glkViewController.view.bottomAnchor.constraint(equalTo: self.viewController.view.bottomAnchor)
		])
		self.glkViewController.didMove(toParent: self.viewController)
	}
	
	func cleanUp() {
		
	}
	
	func updateSize(width: CGFloat, height: CGFloat) {
//		glkView.frame.size.width = width
//		glkView.frame.size.height = height
	}

	
}
