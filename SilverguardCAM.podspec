Pod::Spec.new do |s|
  s.name         = 'SilverguardCAM'
  s.version      = '1.0.1'
  s.summary      = 'Framework SilverguardCAM com código Swift, assets e fontes.'
  s.description  = <<-DESC
    Framework que inclui código Swift, Assets.xcassets e fontes TrueType em Resources.
  DESC
  s.homepage     = 'https://github.com/seuusuario/SilverguardCAM'
  s.license      = { :type => 'MIT', :file => 'LICENSE' }
  s.author       = { 'Seu Nome' => 'seuemail@exemplo.com' }
  s.platform     = :ios, '13.0'
  s.swift_version = '5.0'

  s.source       = { :git => 'https://github.com/seuusuario/SilverguardCAM.git', :tag => s.version.to_s }

  # Código Swift
  s.source_files = 'SilverguardCAM/Sources/SilverguardCAM/**/*.{swift}'

  # Recursos (assets + fontes)
  s.resources = [
    'SilverguardCAM/Sources/SilverguardCAM/Resources/Assets.xcassets',
    'SilverguardCAM/Sources/SilverguardCAM/Resources/**/*.{ttf,otf}'
  ]

  # Certifique-se de que esses recursos estão mesmo no caminho indicado

  # Isso garante que as fontes serão registradas corretamente
  s.resource_bundles = {
    'SilverguardCAMResources' => [
      'SilverguardCAM/Sources/SilverguardCAM/Resources/Assets.xcassets',
      'SilverguardCAM/Sources/SilverguardCAM/Resources/**/*.{ttf,otf}'
    ]
  }

  # Pode ser útil para evitar erro de assinatura em dev
  s.pod_target_xcconfig = {
    'CODE_SIGNING_ALLOWED' => 'NO'
  }
end
