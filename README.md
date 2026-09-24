# Estacionei 🚗🏢

Plataforma de locação inteligente de vagas de garagem em condomínios residenciais e estacionamentos comerciais (Marketplace Bilateral P2P & B2C), com design premium estilo Apple Maps / iOS Dark Mode.

---

## 💎 Versão Final Polida
* **Google Maps Multiplataforma Integrado:** Chave de API Google Maps (`AIzaSyAiRnYGDzYtvKRaTsR6O6EaekbpkEgGn3Y`) 100% configurada e pronta para uso no **Android** (`AndroidManifest.xml`), **Web** (`web/index.html`) e **iOS** (`ios/Runner/AppDelegate.swift`).
* **Favicon & Web Ready:** Ícones web (`favicon.png`, `favicon.ico`, `apple-touch-icon.png`, ícones PWA 192/512 e `manifest.json`) criados e vinculados à identidade visual da marca.
* **Compatibilidade Desktop & Mobile (Draggable Sheet):** A barra retrátil de vagas no mapa agora aceita gestos tanto no celular (toque) quanto no PC (clique e arraste com o mouse / trackpad), graças ao `AppScrollBehavior`.
* **Design System Apple iOS Dark Mode:** Superfícies em vidro fosco (Frosted Glass), paleta Deep Cobalt & Cyan Neon, micro-interações táteis e tipografia limpa.
* **Funcionalidades Completas:**
  1. **Mapa Interativo com Marcadores Semânticos:** Verde (Vagas Livres), Amarelo (Poucas Vagas), Vermelho (Lotado / Fila de Espera).
  2. **Gaveta Retrátil de Garagens (Apple Maps Sheet):** Lista em tempo real com filtros segmentados (Todas, Mensal, Avulso, EV Charger).
  3. **Anúncio de Vaga pelo Morador:** Cadastro ágil com regras condominiais, método de entrada (Portaria, Controle, QR Code) e Pin Picker para localização milimétrica.
  4. **Check-in Digital com QR Code:** Passe condominial criptografado para identificação segura na portaria.
  5. **Fila de Espera Ativa (Waitlist):** Alertas push quando vagas em prédios desejados forem desocupadas.
  6. **Minhas Reservas, Chat em Tempo Real e Gestão de Perfil.**

---

## 🚀 Como Rodar o Projeto

1. Instale as dependências:
```bash
flutter pub get
```

2. Executar no Navegador Web:
```bash
flutter run -d chrome
```

3. Executar no Android:
```bash
flutter run -d android
```

4. Executar no iOS:
```bash
cd ios && pod install && cd ..
flutter run -d ios
```

5. Gerar Build de Produção:
* **Web:** `flutter build web --release`
* **Android (APK):** `flutter build apk --release`
* **iOS (IPA):** `flutter build ipa --release`
