# Estacionei 🚗🏢

> **Marketplace Bilateral (P2P & B2C) de Locação Inteligente de Vagas de Garagem em Condomínios e Estacionamentos Comerciais.**

[![Flutter](https://img.shields.io/badge/Flutter-3.x-02569B?logo=flutter&logoColor=white)](https://flutter.dev)
[![Dart](https://img.shields.io/badge/Dart-3.x-0175C2?logo=dart&logoColor=white)](https://dart.dev)
[![Google Maps](https://img.shields.io/badge/Google%20Maps-SDK%20Integrated-4285F4?logo=googlemaps&logoColor=white)](https://cloud.google.com/maps-platform)
[![Supabase](https://img.shields.io/badge/Supabase-PostgreSQL%20Cloud-3ECF8E?logo=supabase&logoColor=white)](https://supabase.com)
[![Vercel](https://img.shields.io/badge/Vercel-Production%20Live-000000?logo=vercel&logoColor=white)](https://estacioneiapp.vercel.app)
[![Platform](https://img.shields.io/badge/Platforms-Web%20%7C%20iOS%20%7C%20Android-informational)](https://github.com/davixavieerr/Estacionei-App)
[![License](https://img.shields.io/badge/License-MIT-blue.svg)](LICENSE)

---

## 🌐 Demonstração Online & Acesso Imediato

O aplicativo está compilado e publicado em ambiente de produção:

* **URL de Produção:** [https://estacioneiapp.vercel.app](https://estacioneiapp.vercel.app)
* **PWA no iPhone (iOS):** Abra o link no Safari ➔ Toque no ícone de **Compartilhar** ➔ Selecione **"Adicionar à Tela de Início"**. O app abrirá em tela cheia com visual nativo de aplicativo iOS.
* **PWA no Android:** Abra no Chrome ➔ Toque no menu (três pontos) ➔ **"Instalar aplicativo"**.

---

## 📌 Sumário Executivo

1. [Visão Geral & Oportunidade de Mercado](#-visão-geral--oportunidade-de-mercado)
2. [Pilares de Negócio & Diferenciais](#-pilares-de-negócio--diferenciais)
3. [Segurança & Conformidade Jurídica (Lei Federal nº 12.607/2012)](#-segurança--conformidade-jurídica)
4. [Design System Apple iOS Dark Mode](#-design-system-apple-ios-dark-mode)
5. [Arquitetura de Software & Clean Architecture](#-arquitetura-de-software)
6. [Stack Tecnológica Completa](#-stack-tecnológica-completa)
7. [Geocodificação Híbrida Resiliente (4 Níveis)](#-geocodificação-híbrida-resiliente)
8. [Banco de Dados & Schema do Supabase](#-banco-de-dados--schema-do-supabase)
9. [Estrutura de Pastas do Projeto](#-estrutura-de-pastas-do-projeto)
10. [Guia de Configuração e Execução Local](#-guia-de-configuração-e-execução-local)
11. [Build de Produção Multiplataforma](#-build-de-produção-multiplataforma)
12. [Roadmap de Evolução de Produto](#-roadmap-de-evolução-de-produto)

---

## 🏙️ Visão Geral & Oportunidade de Mercado

Em centros urbanos de altíssima densidade como São Paulo, a escassez de estacionamentos representa um dos maiores gargalos de mobilidade urbana e custo operacional. No eixo central da **Avenida Paulista, Paraíso, Jardins, Bela Vista e Consolação**, motoristas e trabalhadores locais pagam entre **R$ 600 e R$ 1.100 mensais** em garagens comerciais frequentemente superlotadas e com rotatividade agressiva.

Em contrapartida, milhares de edifícios residenciais nas mesmas quadras possuem vagas de garagem de escritura ociosas. Condôminos que possuem duas ou mais vagas e utilizam apenas uma não dispunham de um mecanismo digital seguro, padronizado e regulamentado para monetizar esse ativo.

### A Proposta do Estacionei:
Desbloquear o estoque imobiliário oculto de garagens residenciais através de contratos mensais recorrentes (P2P) e integrar redes comerciais com vagas ociosas (B2C), gerando:
* **Para o Motorista:** Redução de até **50% no custo mensal de estacionamento**, vaga fixa coberta e reserva antecipada.
* **Para o Morador (Anfitrião):** Renda passiva recorrente entre **R$ 350 e R$ 600+/mês** por vaga que ficaria trancada e sem uso.
* **Para a Cidade:** Redução do tráfego ocioso de condutores procurando vagas em vias públicas saturadas.

---

## 💎 Pilares de Negócio & Diferenciais

| Pilar | Descrição Funcional | Impacto no Negócio |
| :--- | :--- | :--- |
| **Contratos Mensais Recorrentes (P2P)** | Foco em mensalistas de 1 a 12 meses, além de opção horista/avulsa. | Previsibilidade de receita, alto LTV e baixíssimo *churn*. |
| **Fila de Espera Ativa (Waitlist)** | Prédios com 100% de ocupação (marcadores vermelhos) capturam motoristas interessados. | Zero desperdício de tráfego; conversão imediata assim que uma vaga é liberada. |
| **Trust & Safety Condominial** | Identificação prévia do motorista (placa, modelo, documento) para autorização na portaria. | Supera a resistência conservadora de síndicos e administradoras. |
| **Marketplace Híbrido (P2P + B2C)** | Conecta garagens residenciais de condôminos e estacionamentos comerciais parceiros com seguro total. | Liquidez imediata tanto para quem busca economia quanto para quem busca conveniência rápida. |
| **Simulador Integrado de Rendimentos** | Slider interativo no anúncio que calcula o ganho anual do proprietário da vaga. | Redução do atrito no cadastro de novas vagas ociosas. |

---

## ⚖️ Segurança & Conformidade Jurídica

A operação do **Estacionei** foi estruturada em estrita conformidade com a legislação brasileira:

* **Lei Federal nº 12.607/2012 (Art. 1.331, § 1º do Código Civil):**
  > *"As vagas de garagem não poderão ser vendidas ou alugadas a pessoas estranhas ao condomínio, salvo autorização expressa na convenção de condomínio."*
* **Implementação no App:**
  1. **Termo de Declaração de Convenção:** No fluxo de cadastro da vaga (`AddSpotScreen`), o proprietário declara formalmente que a convenção do seu edifício autoriza a locação externa ou se destina a moradores do mesmo complexo.
  2. **Passe Digital de Condomínio (`CondoPassScreen`):** O locatário recebe um comprovante com QR Code criptografado contendo placa do veículo, documento do condutor, número demarcado da vaga (subsolo/andar) e método de entrada pré-cadastrado (liberação de controle remoto, tag veicular ou autorização formal na portaria).
  3. **Identificação Prévia:** Nenhum acesso é liberado sem a notificação e autorização documentada junto aos operadores de controle de acesso (ex.: Linear-HCS, Intelbras, Porter).

---

## 🎨 Design System Apple iOS Dark Mode

O aplicativo foi desenhado seguindo as diretrizes de interface do **Human Interface Guidelines (HIG)** da Apple, adaptado para alto contraste em telas OLED e uso noturno confortável no trânsito:

* **Paleta de Cores Oficial:**
  * `darkBackground` (`#070C1A`): Fundo azul-noturno ultra profundo.
  * `cardSurface` (`#16203B`): Superfície de cards com elevação visual refinada.
  * `brandGradient`: Gradiente *Deep Cobalt* (`#1E6EE8`) para *Cyan Neon* (`#00D4FF`).
  * `statusGreen` (`#00E676`): Vaga disponível / Confirmação de reserva.
  * `statusYellow` (`#FFD600`): Últimas vagas (1 a 2 restantes) — aciona senso de urgência.
  * `statusRed` (`#FF3B30`): Vaga esgotada — aciona o botão de entrada na Fila de Espera.
* **Componentes de Vidro Fosco (*Frosted Glass*):** Implementação de `BackdropFilter` com desfoque gaussiano de 25px (`ImageFilter.blur(sigmaX: 25, sigmaY: 25)`) e bordas semitransparentes finas (`0.8px`).
* **Gaveta Retrátil de Garagens (Apple Maps Sheet):** `DraggableScrollableSheet` com posições de ancoragem magnética (`snap: 12%`, `20%`, `50%`, `85%`), listando vagas ativas e permitindo navegação fluida.
* **Suporte Universal Desktop & Mobile:** O componente `AppScrollBehavior` no `main.dart` unifica os ponteiros `touch`, `mouse`, `trackpad` e `stylus`, permitindo arrastar gavetas e navegar no PC com o mouse tão suavemente quanto em telas sensíveis ao toque.
* **Dynamic Island Pill:** Pílula superior flutuante que exibe status de reserva ativa em tempo real.

---

## 🏛️ Arquitetura de Software

A base de código utiliza o padrão **Feature-First Clean Architecture**, garantindo que lógica de negócio, persistência de dados e apresentação permaneçam totalmente desacopladas.

```
┌────────────────────────────────────────────────────────┐
│                   APRESENTAÇÃO (UI)                    │
│   MapHomeScreen • AddSpotScreen • SpotDetailsScreen     │
│   BookingCheckoutScreen • CondoPassScreen • Profile     │
└───────────────────────────┬────────────────────────────┘
                            │ (Escuta via ChangeNotifier)
┌───────────────────────────▼────────────────────────────┐
│                    GERÊNCIA DE ESTADO                  │
│       SpotsRepository (Singleton Reativo / Observer)    │
└───────────────────────────┬────────────────────────────┘
                            │ (Requisições HTTP REST assíncronas)
┌───────────────────────────▼────────────────────────────┐
│                 INFRAESTRUTURA & DADOS                 │
│    Supabase PostgREST API • Google Maps SDK • OpenData  │
└────────────────────────────────────────────────────────┘
```

### Características Técnicas:
1. **Reatividade sem Overhead:** Utilização de `ListenableBuilder` e `ChangeNotifier` nativos do Flutter, eliminando dependências pesadas e mantendo tempo de inicialização instantâneo.
2. **Resiliência a Falhas de Rede:** Inicialização imediata com dados em cache/mock estruturado, seguida de sincronização assíncrona com o Supabase sem bloquear a renderização inicial da interface.

---

## 🛠️ Stack Tecnológica Completa

| Categoria | Tecnologia | Justificativa / Função |
| :--- | :--- | :--- |
| **Framework** | [Flutter 3.x](https://flutter.dev) / [Dart 3](https://dart.dev) | Compilação nativa para Web (PWA), Android (APK/AAB) e iOS (IPA) a partir de código único. |
| **Mapas Vetoriais** | `google_maps_flutter` / `google_maps_flutter_web` | Renderização vetorial fluida, controle de câmera de alta precisão e marcadores semânticos. |
| **Estilo do Mapa** | JSON Custom Dark Theme | Estilo noturno exclusivo de alto contraste, minimizando consumo energético em telas OLED. |
| **Ícones do Sistema** | `cupertino_icons` (1.0.8+) | Ícones oficiais do ecossistema Apple iOS (SF Symbols style). |
| **Banco de Dados** | [Supabase](https://supabase.com) (PostgreSQL 15+) | Persistência na nuvem, Row Level Security (RLS) e suporte a queries geoespaciais (PostGIS). |
| **API Client** | `http` (1.2.0+) | Conexão REST direta com a API do Supabase e serviços de geolocalização. |
| **Hospedagem Web** | [Vercel](https://vercel.com) | Edge Network global com compressão gzip/brotli e suporte nativo a PWAs. |

---

## 📍 Geocodificação Híbrida Resiliente

Para garantir que qualquer endereço digitado no anúncio de vaga seja convertido na coordenada exata da portaria (mesmo rodando em navegadores móveis com restrições severas de CORS e cabeçalhos HTTP), foi implementado um mecanismo em **4 camadas de redundância**:

```
[Endereço Digitado pelo Usuário]
               │
               ▼
   [1. Google Maps Geocoding API] ──── (Sucesso) ───► [Coordenadas Exatas]
               │ (Falha / Cota)
               ▼
   [2. OpenStreetMap / Nominatim] ──── (Sucesso) ───► [Coordenadas Exatas]
               │ (Falha / CORS)
               ▼
   [3. Photon Komoot Geocoder]    ──── (Sucesso) ───► [Coordenadas Exatas]
               │ (Offline)
               ▼
   [4. Mapeamento Inteligente SP] ──────────────────► [Coordenadas do Bairro]
```

1. **Camada 1 — Google Maps Geocoding API:** Consulta oficial com a chave do projeto, com precisão no nível do número do lote.
2. **Camada 2 — OpenStreetMap (Nominatim):** Consulta open-source sem cabeçalhos restritos por navegadores web.
3. **Camada 3 — Photon Komoot Geocoder:** Serviço global baseado em OSM com suporte nativo a CORS (`Access-Control-Allow-Origin: *`).
4. **Camada 4 — Fallback Heurístico de Bairros de São Paulo:** Se a conexão falhar totalmente, identifica palavras-chave do endereço (ex.: *Paraíso, Jardins, Oscar Freire, Bela Vista, Pinheiros, Itaim, Moema, Vila Mariana, Consolação*) e posiciona o pino no centro do bairro correspondente, impedindo erros de tela.
5. **Pin Picker Interativo (`LocationPickerScreen`):** O morador pode tocar em *"Ajustar Ponto Exato no Mapa"* para mover o pino com a mão e marcar milimetricamente o portão de entrada da garagem.

---

## 🗄️ Banco de Dados & Schema do Supabase

O projeto conecta-se ao Supabase através da REST API oficial (PostgREST).

### Configuração de Acesso:
* **Project URL:** `https://ugiudafctzdyjtrrmskb.supabase.co`
* **API Key:** `sb_publishable_81Jtp1TVMBjzmRDSDBx-4Q_hU2UYPp7` (Pública para frontend com RLS habilitado).

### Estrutura da Tabela (`parking_spots`):
```sql
CREATE TABLE IF NOT EXISTS parking_spots (
  id TEXT PRIMARY KEY,
  host_id TEXT DEFAULT host_01,
  building_name TEXT NOT NULL,
  address TEXT NOT NULL,
  latitude DOUBLE PRECISION NOT NULL,
  longitude DOUBLE PRECISION NOT NULL,
  spot_type TEXT NOT NULL DEFAULT residential,
  modality TEXT NOT NULL DEFAULT monthlyOnly,
  price_per_month NUMERIC(10, 2),
  price_per_hour NUMERIC(10, 2),
  total_spots INT NOT NULL DEFAULT 1,
  available_spots INT NOT NULL DEFAULT 1,
  min_contract_months INT DEFAULT 1,
  has_ev_charger BOOLEAN DEFAULT FALSE,
  condominium_rules TEXT,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT timezone(utc::text, now()) NOT NULL
);

-- Políticas de Segurança (Row Level Security)
ALTER TABLE parking_spots ENABLE ROW LEVEL SECURITY;

-- Leitura pública para listagem no mapa
CREATE POLICY "Permitir leitura publica das vagas" 
ON parking_spots FOR SELECT 
USING (true);

-- Permissão para cadastro de novos anúncios
CREATE POLICY "Permitir insercao publica das vagas" 
ON parking_spots FOR INSERT 
WITH CHECK (true);
```

---

## 📂 Estrutura de Pastas do Projeto

```
Estacionei-App/
├── android/
│   └── app/src/main/AndroidManifest.xml       # Permissões de GPS e chave Google Maps Android
├── assets/
│   └── images/
│       └── logo.png                           # Logotipo master de alta definição (512x512)
├── ios/
│   └── Runner/
│       ├── AppDelegate.swift                  # Inicialização da chave do Google Maps iOS
│       └── Info.plist                         # Permissões de localização do iOS (GPS)
├── lib/
│   ├── main.dart                              # Ponto de entrada, tema noturno e AppScrollBehavior
│   ├── core/
│   │   ├── constants/
│   │   │   └── map_style.dart                 # JSON do tema Dark Vector para o Google Maps
│   │   ├── theme/
│   │   │   └── app_colors.dart                # Paleta oficial (Cobalt, Cyan Neon, Vidro Fosco)
│   │   └── utils/
│   │       └── formatters.dart                # Utilitários de moeda (BRL) e formatação de datas
│   ├── features/
│   │   ├── auth/presentation/
│   │   │   ├── payment_methods_screen.dart    # Gestão de cartões e chaves Pix do usuário
│   │   │   ├── profile_screen.dart            # Perfil do motorista / anfitrião
│   │   │   ├── security_documents_screen.dart # Envio e validação de CNH e documento do veículo
│   │   │   └── support_screen.dart            # Canal de suporte e atendimento 24/7
│   │   ├── booking/presentation/
│   │   │   ├── booking_checkout_screen.dart   # Checkout com simulação Pix Copia e Cola / Cartão
│   │   │   ├── my_bookings_screen.dart        # Listagem de contratos mensais e reservas ativas
│   │   │   └── qr_code_checkin_screen.dart    # Check-in digital com leitor / exibição de QR Code
│   │   ├── chat/presentation/
│   │   │   └── chat_screen.dart               # Chat em tempo real entre condutor e morador
│   │   ├── map/presentation/
│   │   │   ├── main_shell_screen.dart         # Barra inferior (BottomNavigationBar) com 6 abas
│   │   │   ├── map_home_screen.dart           # Mapa interativo + Apple Maps Draggable Sheet
│   │   │   └── widgets/
│   │   │       ├── map_filter_chips.dart      # Filtros segmentados (Todas, Mensal, Avulso, EV)
│   │   │       ├── map_search_bar.dart        # Barra de pesquisa de logradouros
│   │   │       └── spot_details_card.dart     # Card expansível com dados completos da vaga
│   │   ├── spots/
│   │   │   ├── data/
│   │   │   │   └── spots_repository.dart      # Repositório reativo e integração com Supabase
│   │   │   └── presentation/
│   │   │       ├── add_spot_screen.dart       # Cadastro de vaga, simulador de ganho e geocodificação
│   │   │       ├── condo_pass_screen.dart     # Passe de entrada veicular para a portaria
│   │   │       ├── location_picker_screen.dart# Pin Picker manual para precisão na portaria
│   │   │       ├── my_spots_screen.dart       # Painel de gestão das vagas anunciadas pelo morador
│   │   │       └── spot_details_screen.dart   # Tela detalhada com regras e fotos da vaga
│   │   └── waitlist/presentation/
│   │       └── my_waitlists_screen.dart       # Gestão de alertas de vagas em prédios lotados
│   └── shared/
│       ├── models/
│       │   ├── booking_model.dart             # Modelos de reserva e status de contrato
│       │   ├── chat_message_model.dart        # Modelo de mensagem do chat
│       │   └── parking_spot_model.dart        # Modelo de vaga, serializadores toMap / fromMap
│       └── widgets/
│           └── custom_button.dart             # Botão estilizado com micro-animações táteis
├── web/
│   ├── favicon.ico                            # Favicon multi-resolução para navegadores
│   ├── favicon.png                            # Favicon em alta definição
│   ├── apple-touch-icon.png                   # Ícone oficial para instalação no Safari / iOS
│   ├── index.html                             # Configuração PWA e script do Google Maps Web
│   ├── manifest.json                          # Manifesto de instalação PWA (Nome, Ícones, Cores)
│   └── icons/                                 # Ícones PWA para Android e Desktop (192px e 512px)
├── pubspec.yaml                               # Gerenciamento de dependências e assets
└── README.md                                  # Documentação técnica e de produto
```

---

## 🚀 Guia de Configuração e Execução Local

### Pré-requisitos:
* **Flutter SDK:** Versão 3.22.x ou superior ([Guia de Instalação](https://docs.flutter.dev/get-started/install)).
* **Dart SDK:** Versão 3.0.x ou superior.
* **Navegador:** Google Chrome, Microsoft Edge ou Safari.

### Passo a Passo:

1. **Clonar o Repositório:**
   ```bash
   git clone https://github.com/davixavieerr/Estacionei-App.git
   cd Estacionei-App
   ```

2. **Instalar Dependências:**
   ```bash
   flutter pub get
   ```

3. **Executar em Modo de Desenvolvimento:**
   * **No Navegador Web (Chrome):**
     ```bash
     flutter run -d chrome
     ```
   * **No Emulador ou Dispositivo Físico Android:**
     ```bash
     flutter run -d android
     ```
   * **No Simulador iOS (Requer macOS e Xcode):**
     ```bash
     cd ios && pod install && cd ..
     flutter run -d ios
     ```

---

## 📦 Build de Produção Multiplataforma

### 1. Build para Web (PWA):
```bash
flutter build web --release
```
Os arquivos estáticos otimizados serão gerados em `build/web`. Para atualizar o deploy na Vercel:
```bash
cd build/web
npx vercel --prod
```

### 2. Build para Android (APK de Instalação):
```bash
flutter build apk --release
```
O pacote final será gerado em: `build/app/outputs/flutter-apk/app-release.apk`.

### 3. Build para iOS (Arquivo IPA):
```bash
flutter build ipa --release
```

---

<p align="center">
  Desenvolvido com Flutter 💙 e Google Maps 🗺️ • Estacionei © 2026
</p>
