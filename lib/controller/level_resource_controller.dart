class LevelResources {
  final String videoLink;
  final String sabiasQue;
  final List<Question> questions;

  LevelResources({
    required this.videoLink,
    required this.sabiasQue,
    required this.questions,
  });
}

class Question {
  final String questionText;
  final List<String> options;
  final int correctOptionIndex;
  final String explanation;

  Question({
    required this.questionText,
    required this.options,
    required this.correctOptionIndex,
    required this.explanation,
  });
}

// Datos para el primer nivel
final LevelResources level1Resources = LevelResources(
  videoLink: 'https://youtu.be/BkmQAXhTi9w',
  sabiasQue:
      'Una red de computadoras, también llamada red de ordenadores o red informática, es un conjunto de equipos conectados por medio de cables, señales, ondas o cualquier otro método de transporte de datos, que comparten información, recursos, servicios. Una red de comunicaciones es un conjunto de medios técnicos que permiten la comunicación a distancia entre equipos autónomos.',
  questions: [
    Question(
      questionText:
          'Las redes de computadoras es un importante método de comunicación, que ______________ computadoras entre sí.',
      options: [
        'A) interconecta',
        'B) experiencia',
        'D) desarrollo',
        'E) comunicación'
      ],
      correctOptionIndex: 0,
      explanation:
          'Es por eso que … Una red de computadoras (también llamada red de computadoras o red informática) es un conjunto de equipos (computadoras y/o dispositivos) interconectados por medio de cables, señales, ondas o cualquier otro medio de transporte de datos, que comparten información (archivos), recursos (CD-ROM, impresoras, etc.) y servicios (acceso a internet, e-mail, chat, juegos).',
    ),
    Question(
      questionText:
          'Qué hito marcó el inicio de la mensajería, tal como lo conocemos hoy en día.',
      options: [
        '1. Creación de / email  en 1972.',
        '2. World Wide Web (WWW) en 1991.',
        '3. Intranet en 1989.',
        '4. TCP/IP en 1974.',
      ],
      correctOptionIndex: 0,
      explanation:
          'Es por eso que … El programador estadounidense Ray Tomlinson, utilizó ARPANet para enviar y recibir mensajes sencillos. También fue Tomlinson quien introdujo por primera vez la @ para separar el nombre del usuario y de la máquina en la dirección de correo electrónico.',
    ),
    Question(
      questionText: '¿Cuál fue el primer navegador web para entorno gráfico?',
      options: [
        '1. Mosaic.',
        '2. Fedora.',
        '3. Google Chrome.',
        '4. Kali Linux.',
      ],
      correctOptionIndex: 0,
      explanation:
          'Es por eso que … Mosaic fue creado en febrero de 1993 por un equipo del (NCSA). En el comienzo de su aventura, Mosaic era el primer navegador que podía mostrar contenido multimedia y gráficos en la WWW.',
    ),
    Question(
      questionText:
          '¿Cuál fue la primera red de computadoras a escala mundial?',
      options: [
        '1. Arpanet.',
        '2. World Wide Web.',
        '3. Intranet.',
        '4. Vmware.',
      ],
      correctOptionIndex: 0,
      explanation:
          'Es por eso que … Se establecía la primera interconexión de ARPANET entre los nodos ubicados en la Universidad de California en Los Ángeles, el Stanford Research Institute, la Universidad de California en Santa Barbara y la Universidad de Utah. Esta fecha es considerada un hito en la creación de lo que hoy conocemos como Internet.',
    ),
    Question(
      questionText:
          '¿Cuál fue la primera red social a escala mundial más grande, conocida hoy en día?',
      options: [
        '1. My Space.',
        '2. Facebook.',
        '3. Intranet.',
        '4. Badoo.',
      ],
      correctOptionIndex: 1,
      explanation:
          'Es por eso que … Fundada por Mark Zuckerberg y sus compañeros de cuarto de la universidad, Facebook comenzó como una plataforma exclusiva para estudiantes de la Universidad de Harvard (EE. UU.) antes de expandirse a otras universidades y, finalmente, al público en general. Con sus amplias funciones y la capacidad de unirse a grupos y compartir diversos tipos de contenido, Facebook se convirtió rápidamente en la red social dominante y, casi 20 años después, sigue siéndolo.',
    ),
  ],
);

// Datos para el segundo nivel
final LevelResources level2Resources = LevelResources(
  videoLink: 'https://youtu.be/vRhj-LwCjXM',
  sabiasQue:
      'Las redes se configuran con el objetivo de transmitir datos de un sistema a otro o de disponer recursos en común, como servidores, bases de datos o impresoras. En función del tamaño y del alcance de la red de ordenadores, se puede establecer una diferenciación. \n' 
          'Entre los tipos de redes más importantes se encuentran: \n'
              '•	Personal Area Networks (PAN) o red de área personal \n ' 
          '•	Local Area Networks (LAN) o red de área local \n' 
          '•	Metropolitan Area Networks (MAN) o red de área metropolitana \n ' 
          '•	Wide Area Networks (WAN) o red de área amplia \n',
  questions: [
    Question(
      questionText:
          'Son redes pequeñas que generan un rango de conexión pequeña a través de Bluetooth o infrarrojo. ',
      options: [
        'A)  Red de área personal (PAN)',
        'B) Red de área metropolitana(MAN)',
        'D) Red de área amplia (WAN)',
        'E) Red de área local(LAN) '
      ],
      correctOptionIndex: 0,
      explanation:
          'Es por eso que … Red informática de pocos metros, algo parecido a la distancia que necesita el Bluetooth del móvil para intercambiar datos. Son las más básicas y sirven para espacios reducidos, por ejemplo: si trabajas en un local de una sola planta con un par de ordenadores.',
    ),
    Question(
      questionText:
          '2. Son redes para hogares que generan un rango de conexión no mayor a 50 metros, son la más usadas.   ',
      options: [
        'A)  Red de área personal (PAN)',
        'B) Red de área metropolitana(MAN)',
        'D) Red de área amplia (WAN)',
        'E) Red de área local(LAN)'
      ],
      correctOptionIndex: 3,
      explanation:
          'Es por eso que … Una red local de tales características puede incluir a dos ordenadores en una vivienda privada o a varios miles de dispositivos en una empresa. Asimismo, las redes en instituciones públicas como administraciones, colegios o universidades también son redes LAN.',
    ),
    Question(
      questionText: 'Son redes para conectar más de 100 computadores y tiene un rango no mayor a 10 km, son la más usadas en empresas en toda la ciudad. ',
      options: [
        'A)  Red de área personal (PAN)',
        'B) Red de área metropolitana(MAN)',
        'D) Red de área amplia (WAN)',
        'E) Red de área local(LAN)'
      ],
      correctOptionIndex: 1,
      explanation:
          'Es por eso que … Red de área metropolitana es una red de telecomunicaciones de banda ancha que comunica varias redes LAN en una zona geográficamente cercana. Por lo general, se trata de cada una de las sedes de una empresa que se agrupan en una MAN por medio de líneas arrendadas.',
    ),
    Question(
      questionText:
          'Son redes para conectar más de millones de computadores y tiene un rango a nivel mundial, son las redes utilizadas para internet.',
      options: [
        'A)  Red de área personal (PAN)',
        'B) Red de área metropolitana(MAN)',
        'D) Red de área amplia (WAN)',
        'E) Red de área local(LAN)',
      ],
      correctOptionIndex: 2,
      explanation:
          'Es por eso que … las Wide Área Networks (WAN) o redes de área amplia se extienden por zonas geográficas como países o continentes. El número de redes locales o terminales individuales que forman parte de una WAN es, en principio, ilimitado',
    ),
  ],
);

final LevelResources level3Resources = LevelResources(
  videoLink: 'https://youtu.be/04jfARpozAc',
  sabiasQue:
      'Todos utilizamos redes informáticas en la casa o en el trabajo ya que estas interconectan celulares, computadoras e impresoras. Para que todos estos dispositivos funcionen de la manera más eficiente es necesario planificar la topología de red.\n'
      'La topología de red hace referencia a la forma en la que está dispuesta una red, incluyendo sus nodos –puntos de intersección, conexión o enlace de varios elementos– y las líneas utilizadas para asegurar la transmisión y recepción de datos de manera correcta y segura. Dependiendo de este arreglo, se pueden evitar cortes innecesarios o incrementar el flujo de la información transmitida.',
  questions: [
    Question(
      questionText:
          'Es una topología lineal que recibe y envía información por el mismo canal, causando mucho retraso.',
      options: [
        'A) Topología de Bus',
        'B) Topología de Estrella',
        'D) Topología de Anillo',
        'E) Topología de Árbol',
      ],
      correctOptionIndex: 0,
      explanation:
          'Es por eso que... En esta red informática todos los dispositivos se conectan directamente a un canal y no existe otro vínculo entre nodos. Sin embargo, este sistema también trae aparejado ciertos inconvenientes, como problemas de congestión, colisión y bloqueo. Además, si existe un problema en el canal, todos los dispositivos quedarán desconectados.',
    ),
    Question(
      questionText:
          'Es una topología en la cual todos los equipos están conectados en caso del fallo de un equipo toda la red se desconecta.',
      options: [
        'A) Topología de Bus',
        'B) Topología de Estrella',
        'D) Topología de Anillo',
        'E) Topología de Árbol',
      ],
      correctOptionIndex: 2,
      explanation:
          'Es por eso que... Se trata de una red cerrada formada por distintos componentes que forman una estructura anular. Cada nodo está vinculado solamente con los dos contiguos, por lo que para que la información pueda circular.',
    ),
    Question(
      questionText:
          'Es una topología en la utiliza un switch para enviar y clasificar la información al equipo que solicitó por su propio canal único.',
      options: [
        'A) Topología de Bus',
        'B) Topología de Estrella',
        'D) Topología de Anillo',
        'E) Topología de Árbol',
      ],
      correctOptionIndex: 1,
      explanation:
          'Es por eso que... Es una de las configuraciones más empleadas en Ecuador. Todos los dispositivos se conectan a un punto central, ya sea un concentrador, conmutador o servidor. Este punto funciona como un servidor, controlando y gestionando todas las funciones de la red.',
    ),
    Question(
      questionText:
          'Utilizado para conectar entre dos o más redes, así permite conectar computadoras de redes diferentes con ramificaciones.',
      options: [
        'A) Topología de Bus',
        'B) Topología de Estrella',
        'D) Topología de Anillo',
        'E) Topología de Árbol',
      ],
      correctOptionIndex: 3,
      explanation:
          'Es por eso que... Mezcla la topología de bus y de estrella y permite a los usuarios tener varios servidores. Esta red cuenta con un punto de enlace troncal desde el que se ramifican los demás nodos.',
    ),
    Question(
      questionText:
          'Utilizado para conectar todo tipo de red, así permite conectar todas las computadoras y buscar el mejor camino para llegar a su destino.',
      options: [
        'A) Topología de Bus',
        'B) Topología de Estrella',
        'D) Topología de Anillo',
        'E) Topología de Malla',
      ],
      correctOptionIndex: 3,
      explanation:
          'Es por eso que... En esta clase de red informática todos los componentes se enlazan directamente con todos mediante vías separadas. De esta forma, se ofrecen caminos repetitivos para que, si una conexión falla, la información fluya por varias rutas alternativas. Derivado de ello, proporciona una redundancia y una fiabilidad óptimas.',
    ),
  ],
);

final LevelResources level4Resources = LevelResources(
  videoLink: 'https://youtu.be/dZy9wlR4x64',
  sabiasQue:
      'Los componentes de una red informática son dispositivos informáticos interconectados que se utilizan para compartir información y comunicarse electrónicamente entre una amplia variedad de usuarios. Los dispositivos pueden estar conectados con un cable o pueden usar un método inalámbrico para transmitir la información. Cada configuración requiere algunos componentes de hardware y software para instalar las redes. Estos pueden categorizarse en:\n'
      '• Dispositivos Finales\n'
      '• Medios de Red.\n'
      '• Dispositivos Intermediarios.',
  questions: [
    Question(
      questionText:
          'Si hablamos de un servidor de videos de internet, este vendría a ser.',
      options: [
        'A) Dispositivo Final',
        'B) Medios de Red',
        'D) Dispositivo de apoyo',
        'E) Dispositivo Intermediario',
      ],
      correctOptionIndex: 0,
      explanation:
          'El principal componente de una red informática es el servidor. Los servidores son los encargados del procesamiento de todo el flujo de datos que existe en las redes informáticas atendiendo a todos los ordenadores que forman parte de ella, por lo tanto, sería el dispositivo final en una red.',
    ),
    Question(
      questionText:
          'Si hablamos que en nuestro hogar contamos con un router para nuestra conexión a internet, este vendría a ser.',
      options: [
        'A) Dispositivo Final',
        'B) Medios de Red',
        'D) Dispositivo de apoyo',
        'E) Dispositivo Intermediario',
      ],
      correctOptionIndex: 3,
      explanation:
          'Los enrutadores se utilizan para conectar varios dispositivos con una conexión a Internet. Es un método económico ya que permite compartir información y conectar varios dispositivos a través de una conexión a Internet.',
    ),
    Question(
      questionText:
          'Si se menciona que el servicio de internet llega por cable de fibra óptica hacia nuestro colegio, estamos hablando de.',
      options: [
        'A) Dispositivo Final',
        'B) Medios de Red',
        'D) Dispositivo de apoyo',
        'E) Dispositivo Intermediario',
      ],
      correctOptionIndex: 1,
      explanation:
          'La fibra óptica es un medio físico de transmisión de información, usual en redes de datos y telecomunicaciones, que consiste en un filamento delgado de vidrio o de plástico, a través del cual viajan pulsos de luz láser o led, en la cual se contienen los datos a transmitir.',
    ),
    Question(
      questionText:
          'Cuando hablamos de una impresora hacemos referencia a un dispositivo en la red clasificado como:',
      options: [
        'A) Dispositivo Final',
        'B) Medios de Red',
        'D) Dispositivo de apoyo',
        'E) Dispositivo Intermediario',
      ],
      correctOptionIndex: 0,
      explanation:
          'Las impresoras de red utilizan el concepto de compartir recursos en una red y hacen que esta impresora se encuentre disponible para todos, donde estarán habilitados para imprimir en una ubicación central y de este modo no gastar los recursos de la oficina comprando una impresora individual para cada usuario.',
    ),
    Question(
      questionText:
          'Cuando necesitamos un equipo para crear una red WIFI, ¿qué equipo deberíamos utilizar?',
      options: [
        'A) Switch',
        'B) Hub',
        'D) Tarjeta de red',
        'E) Router',
      ],
      correctOptionIndex: 3,
      explanation:
          'Un router es un equipo inalámbrico capaz de trasmitir una señal inalámbrica. Los dispositivos inalámbricos, como laptops y tablets, utilizan esta señal para conectarse entre sí y a Internet a través de un módem. Los routers inalámbricos generalmente admiten uno de dos estándares inalámbricos.',
    ),
  ],
);

