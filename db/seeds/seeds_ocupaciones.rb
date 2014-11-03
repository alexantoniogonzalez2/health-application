# Ocupaciones
puts 'Ocupaciones'
OcuGrandesGrupos.create! :id => 1, :nombre => 'Directores y gerentes', :codigo => '1'
OcuGrandesGrupos.create! :id => 2, :nombre => 'Profesionales científicos e intelectuales', :codigo => '2'
OcuGrandesGrupos.create! :id => 3, :nombre => 'Técnicos y profesionales de nivel medio', :codigo => '3'
OcuGrandesGrupos.create! :id => 4, :nombre => 'Personal de apoyo administrativo', :codigo => '4'
OcuGrandesGrupos.create! :id => 5, :nombre => 'Trabajadores de los servicios y vendedores de comercios y mercados', :codigo => '5'
OcuGrandesGrupos.create! :id => 6, :nombre => 'Agricultores y trabajadores calificados agropecuarios, forestales y pesqueros', :codigo => '6'
OcuGrandesGrupos.create! :id => 7, :nombre => 'Oficiales, operarios y artesanos de artes mecánicas y de otros oficios', :codigo => '7'
OcuGrandesGrupos.create! :id => 8, :nombre => 'Operadores de instalaciones y máquinas y ensambladores', :codigo => '8'
OcuGrandesGrupos.create! :id => 9, :nombre => 'Ocupaciones elementales', :codigo => '9'
OcuGrandesGrupos.create! :id => 10, :nombre => 'Ocupaciones militares', :codigo => '0'

OcuGrupos.create! :id => 1, :nombre => 'Directores ejecutivos, personal directivo de la administración pública y miembros del poder ejecutivo y de los cuerpos legislativos', :codigo => '11', :gran_grupo_id => 1
OcuGrupos.create! :id => 2, :nombre => 'Directores administradores y comerciales', :codigo => '12', :gran_grupo_id => 1
OcuGrupos.create! :id => 3, :nombre => 'Directores y gerentes de producción y operaciones', :codigo => '13', :gran_grupo_id => 1
OcuGrupos.create! :id => 4, :nombre => 'Gerentes de hoteles, restaurantes, comercios y otros servicios', :codigo => '14', :gran_grupo_id => 1
OcuGrupos.create! :id => 5, :nombre => 'Profesionales de las ciencias y de la ingeniería', :codigo => '21', :gran_grupo_id => 2
OcuGrupos.create! :id => 6, :nombre => 'Profesionales de la salud', :codigo => '22', :gran_grupo_id => 2
OcuGrupos.create! :id => 7, :nombre => 'Profesionales de la enseñanza', :codigo => '23', :gran_grupo_id => 2
OcuGrupos.create! :id => 8, :nombre => 'Especialistas en organización de la administración publica y de empresas', :codigo => '24', :gran_grupo_id => 2
OcuGrupos.create! :id => 9, :nombre => 'Profesionales de tecnología de la información y las comunicaciones', :codigo => '25', :gran_grupo_id => 2
OcuGrupos.create! :id => 10, :nombre => 'Profesionales en derecho, en ciencias sociales y culturales', :codigo => '26', :gran_grupo_id => 2
OcuGrupos.create! :id => 11, :nombre => 'Profesionales de las ciencias y la ingeniería de nivel medio', :codigo => '31', :gran_grupo_id => 3
OcuGrupos.create! :id => 12, :nombre => 'Profesionales de nivel medio de la salud', :codigo => '32', :gran_grupo_id => 3
OcuGrupos.create! :id => 13, :nombre => 'Profesionales de nivel medio en operaciones financieras y administrativas', :codigo => '33', :gran_grupo_id => 3
OcuGrupos.create! :id => 14, :nombre => 'Profesionales de nivel medio de servicios jurídicos, sociales, culturales y afines', :codigo => '34', :gran_grupo_id => 3
OcuGrupos.create! :id => 15, :nombre => 'Técnicos de la tecnología de la información y las comunicaciones', :codigo => '35', :gran_grupo_id => 3
OcuGrupos.create! :id => 16, :nombre => 'Oficinistas', :codigo => '41', :gran_grupo_id => 4
OcuGrupos.create! :id => 17, :nombre => 'Empleados en trato directo con el público', :codigo => '42', :gran_grupo_id => 4
OcuGrupos.create! :id => 18, :nombre => 'Empleados contables y encargados del registro de materiales', :codigo => '43', :gran_grupo_id => 4
OcuGrupos.create! :id => 19, :nombre => 'Otro personal de apoyo administrativo', :codigo => '44', :gran_grupo_id => 4
OcuGrupos.create! :id => 20, :nombre => 'Trabajadores de los servicios personales', :codigo => '51', :gran_grupo_id => 5
OcuGrupos.create! :id => 21, :nombre => 'Vendedores', :codigo => '52', :gran_grupo_id => 5
OcuGrupos.create! :id => 22, :nombre => 'Trabajadores de los cuidados personales', :codigo => '53', :gran_grupo_id => 5
OcuGrupos.create! :id => 23, :nombre => 'Personal de los servicios de protección', :codigo => '54', :gran_grupo_id => 5
OcuGrupos.create! :id => 24, :nombre => 'Agricultores y trabajadores calificados de explotaciones agropecuarias con destino al mercado', :codigo => '61', :gran_grupo_id => 6
OcuGrupos.create! :id => 25, :nombre => 'Trabajadores forestales calificados, pescadores y cazadores', :codigo => '62', :gran_grupo_id => 6
OcuGrupos.create! :id => 26, :nombre => 'Trabajadores agropecuarios, pescadores, cazadores y recolectores de subsistencia', :codigo => '63', :gran_grupo_id => 6
OcuGrupos.create! :id => 27, :nombre => 'Oficiales y operarios de la construcción excluyendo electricistas', :codigo => '71', :gran_grupo_id => 7
OcuGrupos.create! :id => 28, :nombre => 'Oficiales y operarios de la metalurgia, la construcción mecánica y afines', :codigo => '72', :gran_grupo_id => 7
OcuGrupos.create! :id => 29, :nombre => 'Artesanos y operarios de las artes gráficas', :codigo => '73', :gran_grupo_id => 7
OcuGrupos.create! :id => 30, :nombre => 'Trabajadores especializados en electricidad y la elecrotecnología', :codigo => '74', :gran_grupo_id => 7
OcuGrupos.create! :id => 31, :nombre => 'Operarios y oficiales de procesamiento de alimentos, de la confección, ebanistas, otros artesanos y afines', :codigo => '75', :gran_grupo_id => 7
OcuGrupos.create! :id => 32, :nombre => 'Operadores de instalaciones fijas y máquinas', :codigo => '81', :gran_grupo_id => 8
OcuGrupos.create! :id => 33, :nombre => 'Ensambladores', :codigo => '82', :gran_grupo_id => 8
OcuGrupos.create! :id => 34, :nombre => 'Conductores de vehículos y operadores de equipos pesados móviles', :codigo => '83', :gran_grupo_id => 8
OcuGrupos.create! :id => 35, :nombre => 'Limpiadores y asistentes', :codigo => '91', :gran_grupo_id => 9
OcuGrupos.create! :id => 36, :nombre => 'Peones agropecuarios, pesqueros y forestales', :codigo => '92', :gran_grupo_id => 9
OcuGrupos.create! :id => 37, :nombre => 'Peones de la minería, la construcción, la industria manufacturera y el transporte', :codigo => '93', :gran_grupo_id => 9
OcuGrupos.create! :id => 38, :nombre => 'Ayudantes de preparación de alimentos', :codigo => '94', :gran_grupo_id => 9
OcuGrupos.create! :id => 39, :nombre => 'Vendedores ambulantes de servicios y afines', :codigo => '95', :gran_grupo_id => 9
OcuGrupos.create! :id => 40, :nombre => 'Recolectores de desechos y otras ocupaciones elementales', :codigo => '96', :gran_grupo_id => 9
OcuGrupos.create! :id => 41, :nombre => 'Oficiales de las fuerzas armadas', :codigo => '01', :gran_grupo_id => 10
OcuGrupos.create! :id => 42, :nombre => 'Suboficiales de las fuerzas armadas', :codigo => '02', :gran_grupo_id => 10
OcuGrupos.create! :id => 43, :nombre => 'Otros miembros de las fuerzas armadas', :codigo => '03', :gran_grupo_id => 10

OcuSubgrupos.create! :id => 1, :nombre => 'Miembros del poder ejecutivo y de los cuerpos legislativos', :codigo => '111', :grupo_id => 1
OcuSubgrupos.create! :id => 2, :nombre => 'Directores generales y gerentes generales', :codigo => '112', :grupo_id => 1
OcuSubgrupos.create! :id => 3, :nombre => 'Directores de administración y servicios', :codigo => '121', :grupo_id => 2
OcuSubgrupos.create! :id => 4, :nombre => 'Directores de ventas, comercialización y desarrollo', :codigo => '122', :grupo_id => 2
OcuSubgrupos.create! :id => 5, :nombre => 'Directores de producción agropecuaria, silvicultura y pesca', :codigo => '131', :grupo_id => 3
OcuSubgrupos.create! :id => 6, :nombre => 'Directores de industrias manufactureras, de minería, construcción y distribución', :codigo => '132', :grupo_id => 3
OcuSubgrupos.create! :id => 7, :nombre => 'Directores de servicios de tecnología de la información y las comunicaciones', :codigo => '133', :grupo_id => 3
OcuSubgrupos.create! :id => 8, :nombre => 'Directores  y gerentes de servicios profesionales', :codigo => '134', :grupo_id => 3
OcuSubgrupos.create! :id => 9, :nombre => 'Gerentes de hoteles y restaurantes', :codigo => '141', :grupo_id => 4
OcuSubgrupos.create! :id => 10, :nombre => 'Gerentes de comercios al por mayor y al por menor', :codigo => '142', :grupo_id => 4
OcuSubgrupos.create! :id => 11, :nombre => 'Otros gerentes de servicios', :codigo => '143', :grupo_id => 4
OcuSubgrupos.create! :id => 12, :nombre => 'Físicos, químicos y afines', :codigo => '211', :grupo_id => 5
OcuSubgrupos.create! :id => 13, :nombre => 'Matemáticos, actuarios y estadísticos', :codigo => '212', :grupo_id => 5
OcuSubgrupos.create! :id => 14, :nombre => 'Profesionales en ciencias biológicas', :codigo => '213', :grupo_id => 5
OcuSubgrupos.create! :id => 15, :nombre => 'Ingenieros (excluyendo electrotecnólogos)', :codigo => '214', :grupo_id => 5
OcuSubgrupos.create! :id => 16, :nombre => 'Ingenieros en electrotecnología', :codigo => '215', :grupo_id => 5
OcuSubgrupos.create! :id => 17, :nombre => 'Arquitectos, urbanistas, agrimensores y diseñadores', :codigo => '216', :grupo_id => 5
OcuSubgrupos.create! :id => 18, :nombre => 'Médicos', :codigo => '221', :grupo_id => 6
OcuSubgrupos.create! :id => 19, :nombre => 'Profesionales de enfermería y partería', :codigo => '222', :grupo_id => 6
OcuSubgrupos.create! :id => 20, :nombre => 'Profesionales de medicina tradicional y alternativa', :codigo => '223', :grupo_id => 6
OcuSubgrupos.create! :id => 21, :nombre => 'Practicantes paramédicos', :codigo => '224', :grupo_id => 6
OcuSubgrupos.create! :id => 22, :nombre => 'Veterinarios', :codigo => '225', :grupo_id => 6
OcuSubgrupos.create! :id => 23, :nombre => 'Otros profesionales de la salud', :codigo => '226', :grupo_id => 6
OcuSubgrupos.create! :id => 24, :nombre => 'Profesores de universidades y de la enseñanza superior', :codigo => '231', :grupo_id => 7
OcuSubgrupos.create! :id => 25, :nombre => 'Profesores de formación profesional', :codigo => '232', :grupo_id => 7
OcuSubgrupos.create! :id => 26, :nombre => 'Profesores de enseñanza secundaria', :codigo => '233', :grupo_id => 7
OcuSubgrupos.create! :id => 27, :nombre => 'Maestros de enseñanza primaria y maestros preescolares', :codigo => '234', :grupo_id => 7
OcuSubgrupos.create! :id => 28, :nombre => 'Otros profesionales de la enseñanza', :codigo => '235', :grupo_id => 7
OcuSubgrupos.create! :id => 29, :nombre => 'Especialistas en finanzas', :codigo => '241', :grupo_id => 8
OcuSubgrupos.create! :id => 30, :nombre => 'Especialistas en organización de administración', :codigo => '242', :grupo_id => 8
OcuSubgrupos.create! :id => 31, :nombre => 'Profesionales de las ventas, la comercialización y las relaciones públicas', :codigo => '243', :grupo_id => 8
OcuSubgrupos.create! :id => 32, :nombre => 'Desarrolladores y analistas de software y multimedia', :codigo => '251', :grupo_id => 9
OcuSubgrupos.create! :id => 33, :nombre => 'Especialistas en bases de datos y en redes de computadores', :codigo => '252', :grupo_id => 9
OcuSubgrupos.create! :id => 34, :nombre => 'Profesionales en derecho', :codigo => '261', :grupo_id => 10
OcuSubgrupos.create! :id => 35, :nombre => 'Archivistas, bibliotecarios, curadores y afines', :codigo => '262', :grupo_id => 10
OcuSubgrupos.create! :id => 36, :nombre => 'Especialistas en ciencias sociales y teología', :codigo => '263', :grupo_id => 10
OcuSubgrupos.create! :id => 37, :nombre => 'Autores, periodistas y lingüistas', :codigo => '264', :grupo_id => 10
OcuSubgrupos.create! :id => 38, :nombre => 'Artistas creativos e interpretativos', :codigo => '265', :grupo_id => 10
OcuSubgrupos.create! :id => 39, :nombre => 'Técnicos en ciencias físicas y en ingeniería', :codigo => '311', :grupo_id => 11
OcuSubgrupos.create! :id => 40, :nombre => 'Supervisores en ingeniería de minas, de industrias manufactureras y de la construcción', :codigo => '312', :grupo_id => 11
OcuSubgrupos.create! :id => 41, :nombre => 'Técnicos en control de procesos', :codigo => '313', :grupo_id => 11
OcuSubgrupos.create! :id => 42, :nombre => 'Técnicos y profesionales de nivel medio en ciencias biológicas y afines', :codigo => '314', :grupo_id => 11
OcuSubgrupos.create! :id => 43, :nombre => 'Técnicos y controladores en navegación marítima y aeronáutica', :codigo => '315', :grupo_id => 11
OcuSubgrupos.create! :id => 44, :nombre => 'Técnicos médicos y farmacéuticos', :codigo => '321', :grupo_id => 12
OcuSubgrupos.create! :id => 45, :nombre => 'Profesionales de nivel medio de enfermería y partería', :codigo => '322', :grupo_id => 12
OcuSubgrupos.create! :id => 46, :nombre => 'Profesionales de nivel medio de medicina tradicional y alternativa', :codigo => '323', :grupo_id => 12
OcuSubgrupos.create! :id => 47, :nombre => 'Técnicos y asistentes veterinarios', :codigo => '324', :grupo_id => 12
OcuSubgrupos.create! :id => 48, :nombre => 'Otros profesionales de nivel medio de la salud', :codigo => '325', :grupo_id => 12
OcuSubgrupos.create! :id => 49, :nombre => 'Profesionales de nivel medio en finanzas y matemáticas', :codigo => '331', :grupo_id => 13
OcuSubgrupos.create! :id => 50, :nombre => 'Agentes comerciales y corredores', :codigo => '332', :grupo_id => 13
OcuSubgrupos.create! :id => 51, :nombre => 'Agentes de servicios comerciales', :codigo => '333', :grupo_id => 13
OcuSubgrupos.create! :id => 52, :nombre => 'Secretarios administrativos y especializados', :codigo => '334', :grupo_id => 13
OcuSubgrupos.create! :id => 53, :nombre => 'Agentes de la administración pública para la aplicación de la ley y afines', :codigo => '335', :grupo_id => 13
OcuSubgrupos.create! :id => 54, :nombre => 'Profesionales de nivel medio, de servicios jurídicos, sociales y religiosos', :codigo => '341', :grupo_id => 14
OcuSubgrupos.create! :id => 55, :nombre => 'Entrenadores de deportes y aptitud física', :codigo => '342', :grupo_id => 14
OcuSubgrupos.create! :id => 56, :nombre => 'Profesionales de nivel medio en actividades culturales, artísticas y culinarias', :codigo => '343', :grupo_id => 14
OcuSubgrupos.create! :id => 57, :nombre => 'Técnicos en operaciones de tecnología de la información y las comunicaciones y asistencia al usuario', :codigo => '351', :grupo_id => 15
OcuSubgrupos.create! :id => 58, :nombre => 'Técnicos en telecomunicaciones y radiodifusión', :codigo => '352', :grupo_id => 15
OcuSubgrupos.create! :id => 59, :nombre => 'Oficinistas generales', :codigo => '411', :grupo_id => 16
OcuSubgrupos.create! :id => 60, :nombre => 'Secretarios (general)', :codigo => '412', :grupo_id => 16
OcuSubgrupos.create! :id => 61, :nombre => 'Operadores de máquinas de oficina', :codigo => '413', :grupo_id => 16
OcuSubgrupos.create! :id => 62, :nombre => 'Pagadores y cobradores de ventanilla y afines', :codigo => '421', :grupo_id => 17
OcuSubgrupos.create! :id => 63, :nombre => 'Empleados de servicios de información al cliente', :codigo => '422', :grupo_id => 17
OcuSubgrupos.create! :id => 64, :nombre => 'Auxiliares contables y financieros', :codigo => '431', :grupo_id => 18
OcuSubgrupos.create! :id => 65, :nombre => 'Empleados encargados del registro de materiales y de transportes', :codigo => '432', :grupo_id => 18
OcuSubgrupos.create! :id => 66, :nombre => 'Otro personal de apoyo administrativo', :codigo => '441', :grupo_id => 19
OcuSubgrupos.create! :id => 67, :nombre => 'Personal al servicio directo de los pasajeros', :codigo => '511', :grupo_id => 20
OcuSubgrupos.create! :id => 68, :nombre => 'Cocineros', :codigo => '512', :grupo_id => 20
OcuSubgrupos.create! :id => 69, :nombre => 'Camareros', :codigo => '513', :grupo_id => 20
OcuSubgrupos.create! :id => 70, :nombre => 'Peluqueros, especialistas en tratamientos de belleza y afines', :codigo => '514', :grupo_id => 20
OcuSubgrupos.create! :id => 71, :nombre => 'Supervisores de mantenimiento y limpieza de edificios', :codigo => '515', :grupo_id => 20
OcuSubgrupos.create! :id => 72, :nombre => 'Otros trabajadores de servicios personales', :codigo => '516', :grupo_id => 20
OcuSubgrupos.create! :id => 73, :nombre => 'Vendedores callejeros y de puestos de mercado', :codigo => '521', :grupo_id => 21
OcuSubgrupos.create! :id => 74, :nombre => 'Comerciantes y vendedores de tiendas y almacenes', :codigo => '522', :grupo_id => 21
OcuSubgrupos.create! :id => 75, :nombre => 'Cajeros y expendedores de billetes', :codigo => '523', :grupo_id => 21
OcuSubgrupos.create! :id => 76, :nombre => 'Otros vendedores', :codigo => '524', :grupo_id => 21
OcuSubgrupos.create! :id => 77, :nombre => 'Cuidadores de niños y auxiliares de maestros', :codigo => '531', :grupo_id => 22
OcuSubgrupos.create! :id => 78, :nombre => 'Trabajadores de los cuidados personales en servicios de salud', :codigo => '532', :grupo_id => 22
OcuSubgrupos.create! :id => 79, :nombre => 'Personal de los servicios de protección', :codigo => '541', :grupo_id => 23
OcuSubgrupos.create! :id => 80, :nombre => 'Agricultores y trabajadores calificados de jardines y de cultivos para el mercado', :codigo => '611', :grupo_id => 24
OcuSubgrupos.create! :id => 81, :nombre => 'Criadores y trabajadores pecuarios calificados de la cría de animales para el mercado y afines', :codigo => '612', :grupo_id => 24
OcuSubgrupos.create! :id => 82, :nombre => 'Productores y trabajadores calificados de explotaciones agropecuarias mixtas cuya producción se destina al mercado', :codigo => '613', :grupo_id => 24
OcuSubgrupos.create! :id => 83, :nombre => 'Trabajadores forestales calificados y afines', :codigo => '621', :grupo_id => 25
OcuSubgrupos.create! :id => 84, :nombre => 'Pescadores, cazadores y tramperos', :codigo => '622', :grupo_id => 25
OcuSubgrupos.create! :id => 85, :nombre => 'Trabajadores agrícolas de subsistencia', :codigo => '631', :grupo_id => 26
OcuSubgrupos.create! :id => 86, :nombre => 'Trabajadores pecuarios de subsistencia', :codigo => '632', :grupo_id => 26
OcuSubgrupos.create! :id => 87, :nombre => 'Trabajadores agropecuarios de subsistencia', :codigo => '633', :grupo_id => 26
OcuSubgrupos.create! :id => 88, :nombre => 'Pescadores, cazadores, tramperos y recolectores de subsistencia', :codigo => '634', :grupo_id => 26
OcuSubgrupos.create! :id => 89, :nombre => 'Oficiales y operarios de la construcción (obra gruesa) y afines', :codigo => '711', :grupo_id => 27
OcuSubgrupos.create! :id => 90, :nombre => 'Oficiales y operarios de la construcción (trabajos de acabado) y afines', :codigo => '712', :grupo_id => 27
OcuSubgrupos.create! :id => 91, :nombre => 'Pintores, limpiadores de fachadas y afines', :codigo => '713', :grupo_id => 27
OcuSubgrupos.create! :id => 92, :nombre => 'Moldeadores, soldadores, chapistas, caldereros, montadores de estructuras metálicas y afines', :codigo => '721', :grupo_id => 28
OcuSubgrupos.create! :id => 93, :nombre => 'Herreros, herramentistas y afines', :codigo => '722', :grupo_id => 28
OcuSubgrupos.create! :id => 94, :nombre => 'Mecánicos y reparadores de máquinas', :codigo => '723', :grupo_id => 28
OcuSubgrupos.create! :id => 95, :nombre => 'Artesanos', :codigo => '731', :grupo_id => 29
OcuSubgrupos.create! :id => 96, :nombre => 'Oficiales y operarios de las artes gráficas', :codigo => '732', :grupo_id => 29
OcuSubgrupos.create! :id => 97, :nombre => 'Instaladores y reparadores de equipos eléctricos', :codigo => '741', :grupo_id => 30
OcuSubgrupos.create! :id => 98, :nombre => 'Instaladores y reparadores de equipos electrónicos y de telecomunicaciones', :codigo => '742', :grupo_id => 30
OcuSubgrupos.create! :id => 99, :nombre => 'Oficiales y operarios de procesamiento de alimentos y afines', :codigo => '751', :grupo_id => 31
OcuSubgrupos.create! :id => 100, :nombre => 'Oficiales y operarios del tratamiento de la madera, ebanistas y afines', :codigo => '752', :grupo_id => 31
OcuSubgrupos.create! :id => 101, :nombre => 'Oficiales y operarios de la confección y afines', :codigo => '753', :grupo_id => 31
OcuSubgrupos.create! :id => 102, :nombre => 'Otros oficiales, operarios y artesanos de artes mecánicas y de otros oficios', :codigo => '754', :grupo_id => 31
OcuSubgrupos.create! :id => 103, :nombre => 'Operadores de instalaciones mineras y de extracción y procesamiento de minerales', :codigo => '811', :grupo_id => 32
OcuSubgrupos.create! :id => 104, :nombre => 'Operadores de instalaciones de procesamiento y recubridoras de metales', :codigo => '812', :grupo_id => 32
OcuSubgrupos.create! :id => 105, :nombre => 'Operadores de instalaciones y máquinas de productos químicos y fotográficos', :codigo => '813', :grupo_id => 32
OcuSubgrupos.create! :id => 106, :nombre => 'Operadores de máquinas para fabricar productos de caucho, de papel y de material plástico', :codigo => '814', :grupo_id => 32
OcuSubgrupos.create! :id => 107, :nombre => 'Operadores de máquinas para fabricar productos textiles y artículos de piel y cuero', :codigo => '815', :grupo_id => 32
OcuSubgrupos.create! :id => 108, :nombre => 'Operadores de máquinas para elaborar alimentos y productos afines', :codigo => '816', :grupo_id => 32
OcuSubgrupos.create! :id => 109, :nombre => 'Operadores de instalaciones para la preparación de papel y de procesamiento de la madera', :codigo => '817', :grupo_id => 32
OcuSubgrupos.create! :id => 110, :nombre => 'Otros operadores de máquinas y de instalaciones fijas', :codigo => '818', :grupo_id => 32
OcuSubgrupos.create! :id => 111, :nombre => 'Ensambladores', :codigo => '821', :grupo_id => 33
OcuSubgrupos.create! :id => 112, :nombre => 'Maquinistas de locomotoras y afines', :codigo => '831', :grupo_id => 34
OcuSubgrupos.create! :id => 113, :nombre => 'Conductores de automóviles, camionetas y motocicletas', :codigo => '832', :grupo_id => 34
OcuSubgrupos.create! :id => 114, :nombre => 'Conductores de camiones pesados y autobuses', :codigo => '833', :grupo_id => 34
OcuSubgrupos.create! :id => 115, :nombre => 'Operadores de equipos pesados móviles', :codigo => '834', :grupo_id => 34
OcuSubgrupos.create! :id => 116, :nombre => 'Marineros de cubierta y afines', :codigo => '835', :grupo_id => 34
OcuSubgrupos.create! :id => 117, :nombre => 'Limpiadores y asistentes domésticos de hoteles y oficinas', :codigo => '911', :grupo_id => 35
OcuSubgrupos.create! :id => 118, :nombre => 'Limpiadores de vehículos, ventanas, ropa y otra limpieza a mano', :codigo => '912', :grupo_id => 35
OcuSubgrupos.create! :id => 119, :nombre => 'Peones agropecuarios, pesqueros y forestales', :codigo => '921', :grupo_id => 36
OcuSubgrupos.create! :id => 120, :nombre => 'Peones de la minería y la construcción', :codigo => '931', :grupo_id => 37
OcuSubgrupos.create! :id => 121, :nombre => 'Peones de la industria manufacturera', :codigo => '932', :grupo_id => 37
OcuSubgrupos.create! :id => 122, :nombre => 'Peones del transporte y almacenamiento', :codigo => '933', :grupo_id => 37
OcuSubgrupos.create! :id => 123, :nombre => 'Ayudantes de preparación de alimentos', :codigo => '941', :grupo_id => 38
OcuSubgrupos.create! :id => 124, :nombre => 'Trabajadores ambulantes de servicios y afines', :codigo => '951', :grupo_id => 39
OcuSubgrupos.create! :id => 125, :nombre => 'Vendedores ambulantes (excluyendo de comida)', :codigo => '952', :grupo_id => 39
OcuSubgrupos.create! :id => 126, :nombre => 'Recolectores de desechos', :codigo => '961', :grupo_id => 40
OcuSubgrupos.create! :id => 127, :nombre => 'Otras ocupaciones elementales', :codigo => '962', :grupo_id => 40
OcuSubgrupos.create! :id => 128, :nombre => 'Oficiales de las fuerzas armadas', :codigo => '011', :grupo_id => 41
OcuSubgrupos.create! :id => 129, :nombre => 'Suboficiales de las fuerzas armadas', :codigo => '021', :grupo_id => 42
OcuSubgrupos.create! :id => 130, :nombre => 'Otros miembros de las fuerzas armadas', :codigo => '031', :grupo_id => 43

OcuOcupaciones.create! :id => 1, :nombre => 'Miembros del poder legislativo', :codigo => '1111', :subgrupo_id => 1
OcuOcupaciones.create! :id => 2, :nombre => 'Personal directivo de la administración pública', :codigo => '1112', :subgrupo_id => 1
OcuOcupaciones.create! :id => 3, :nombre => 'Jefes de pequeñas poblaciones', :codigo => '1113', :subgrupo_id => 1
OcuOcupaciones.create! :id => 4, :nombre => 'Dirigentes de organizaciones que presentan un interés especial', :codigo => '1114', :subgrupo_id => 1
OcuOcupaciones.create! :id => 5, :nombre => 'Directores generales y gerentes generales', :codigo => '1120', :subgrupo_id => 2
OcuOcupaciones.create! :id => 6, :nombre => 'Directores financieros', :codigo => '1211', :subgrupo_id => 3
OcuOcupaciones.create! :id => 7, :nombre => 'Directores de recursos humanos', :codigo => '1212', :subgrupo_id => 3
OcuOcupaciones.create! :id => 8, :nombre => 'Directores de políticas y planificación', :codigo => '1213', :subgrupo_id => 3
OcuOcupaciones.create! :id => 9, :nombre => 'Directores de administración y servicios no clasificados bajo otros epígrafes', :codigo => '1219', :subgrupo_id => 3
OcuOcupaciones.create! :id => 10, :nombre => 'Directores de ventas y comercialización', :codigo => '1221', :subgrupo_id => 4
OcuOcupaciones.create! :id => 11, :nombre => 'Directores de publicidad y relaciones públicas', :codigo => '1222', :subgrupo_id => 4
OcuOcupaciones.create! :id => 12, :nombre => 'Directores de investigación y desarrollo', :codigo => '1223', :subgrupo_id => 4
OcuOcupaciones.create! :id => 13, :nombre => 'Directores de producción agropecuaria y silvicultura', :codigo => '1311', :subgrupo_id => 5
OcuOcupaciones.create! :id => 14, :nombre => 'Directores de producción de piscicultura y pesca', :codigo => '1312', :subgrupo_id => 5
OcuOcupaciones.create! :id => 15, :nombre => 'Directores de industrias manufactureras', :codigo => '1321', :subgrupo_id => 6
OcuOcupaciones.create! :id => 16, :nombre => 'Directores de explotaciones de minería', :codigo => '1322', :subgrupo_id => 6
OcuOcupaciones.create! :id => 17, :nombre => 'Directores de empresas de construcción', :codigo => '1323', :subgrupo_id => 6
OcuOcupaciones.create! :id => 18, :nombre => 'Directores de empresas de abastecimiento, distribución y afines', :codigo => '1324', :subgrupo_id => 6
OcuOcupaciones.create! :id => 19, :nombre => 'Directores de servicios de tecnología de la información y las comunicaciones', :codigo => '1330', :subgrupo_id => 7
OcuOcupaciones.create! :id => 20, :nombre => 'Directores de servicios de cuidados infantiles', :codigo => '1341', :subgrupo_id => 8
OcuOcupaciones.create! :id => 21, :nombre => 'Directores de servicios de salud', :codigo => '1342', :subgrupo_id => 8
OcuOcupaciones.create! :id => 22, :nombre => 'Directores de servicios de cuidado de las personas de edad', :codigo => '1343', :subgrupo_id => 8
OcuOcupaciones.create! :id => 23, :nombre => 'Directores  de servicios de bienestar social', :codigo => '1344', :subgrupo_id => 8
OcuOcupaciones.create! :id => 24, :nombre => 'Directores de servicios de educación', :codigo => '1345', :subgrupo_id => 8
OcuOcupaciones.create! :id => 25, :nombre => 'Gerentes de sucursales de bancos, de servicios financieros y de seguros', :codigo => '1346', :subgrupo_id => 8
OcuOcupaciones.create! :id => 26, :nombre => 'Directores y gerentes de servicios profesionales no clasificados bajo otros epígrafes', :codigo => '1349', :subgrupo_id => 8
OcuOcupaciones.create! :id => 27, :nombre => 'Gerentes de hoteles', :codigo => '1411', :subgrupo_id => 9
OcuOcupaciones.create! :id => 28, :nombre => 'Gerentes de restaurantes', :codigo => '1412', :subgrupo_id => 9
OcuOcupaciones.create! :id => 29, :nombre => 'Gerentes de comercios al por mayor y al por menor', :codigo => '1420', :subgrupo_id => 10
OcuOcupaciones.create! :id => 30, :nombre => 'Gerentes de centros deportivos, de esparcimiento y culturales', :codigo => '1431', :subgrupo_id => 11
OcuOcupaciones.create! :id => 31, :nombre => 'Gerentes de servicios no clasificados bajo otros epígrafes', :codigo => '1439', :subgrupo_id => 11
OcuOcupaciones.create! :id => 32, :nombre => 'Físicos y astrónomos', :codigo => '2111', :subgrupo_id => 12
OcuOcupaciones.create! :id => 33, :nombre => 'Meteorólogos', :codigo => '2112', :subgrupo_id => 12
OcuOcupaciones.create! :id => 34, :nombre => 'Químicos', :codigo => '2113', :subgrupo_id => 12
OcuOcupaciones.create! :id => 35, :nombre => 'Geólogos y geofísicos', :codigo => '2114', :subgrupo_id => 12
OcuOcupaciones.create! :id => 36, :nombre => 'Matemáticos, actuarios y estadísticos', :codigo => '2120', :subgrupo_id => 13
OcuOcupaciones.create! :id => 37, :nombre => 'Biólogos, botánicos, zoólogos y afines', :codigo => '2131', :subgrupo_id => 14
OcuOcupaciones.create! :id => 38, :nombre => 'Agrónomos y afines', :codigo => '2132', :subgrupo_id => 14
OcuOcupaciones.create! :id => 39, :nombre => 'Profesionales de la protección medioambiental', :codigo => '2133', :subgrupo_id => 14
OcuOcupaciones.create! :id => 40, :nombre => 'Ingenieros industriales y de producción', :codigo => '2141', :subgrupo_id => 15
OcuOcupaciones.create! :id => 41, :nombre => 'Ingenieros civiles', :codigo => '2142', :subgrupo_id => 15
OcuOcupaciones.create! :id => 42, :nombre => 'Ingenieros medioambientales', :codigo => '2143', :subgrupo_id => 15
OcuOcupaciones.create! :id => 43, :nombre => 'Ingenieros mecánicos', :codigo => '2144', :subgrupo_id => 15
OcuOcupaciones.create! :id => 44, :nombre => 'Ingenieros químicos', :codigo => '2145', :subgrupo_id => 15
OcuOcupaciones.create! :id => 45, :nombre => 'Ingenieros de minas, metalúrgicos y afines', :codigo => '2146', :subgrupo_id => 15
OcuOcupaciones.create! :id => 46, :nombre => 'Ingenieros no clasificados bajo otros epígrafes', :codigo => '2149', :subgrupo_id => 15
OcuOcupaciones.create! :id => 47, :nombre => 'Ingenieros electricistas', :codigo => '2151', :subgrupo_id => 16
OcuOcupaciones.create! :id => 48, :nombre => 'Ingenieros electrónicos', :codigo => '2152', :subgrupo_id => 16
OcuOcupaciones.create! :id => 49, :nombre => 'Ingenieros en telecomunicaciones', :codigo => '2153', :subgrupo_id => 16
OcuOcupaciones.create! :id => 50, :nombre => 'Arquitectos', :codigo => '2161', :subgrupo_id => 17
OcuOcupaciones.create! :id => 51, :nombre => 'Arquitectos paisajistas', :codigo => '2162', :subgrupo_id => 17
OcuOcupaciones.create! :id => 52, :nombre => 'Diseñadores de productos y de prendas', :codigo => '2163', :subgrupo_id => 17
OcuOcupaciones.create! :id => 53, :nombre => 'Urbanistas e ingenieros de tránsito', :codigo => '2164', :subgrupo_id => 17
OcuOcupaciones.create! :id => 54, :nombre => 'Cartógrafos y agrimensores', :codigo => '2165', :subgrupo_id => 17
OcuOcupaciones.create! :id => 55, :nombre => 'Diseñadores gráficos y multimedia', :codigo => '2166', :subgrupo_id => 17
OcuOcupaciones.create! :id => 56, :nombre => 'Médicos generales', :codigo => '2211', :subgrupo_id => 18
OcuOcupaciones.create! :id => 57, :nombre => 'Médicos especialistas ', :codigo => '2212', :subgrupo_id => 18
OcuOcupaciones.create! :id => 58, :nombre => 'Profesionales de enfermería', :codigo => '2221', :subgrupo_id => 19
OcuOcupaciones.create! :id => 59, :nombre => 'Profesionales de partería', :codigo => '2222', :subgrupo_id => 19
OcuOcupaciones.create! :id => 60, :nombre => 'Profesionales de medicina tradicional y alternativa', :codigo => '2230', :subgrupo_id => 20
OcuOcupaciones.create! :id => 61, :nombre => 'Practicantes paramédicos', :codigo => '2240', :subgrupo_id => 21
OcuOcupaciones.create! :id => 62, :nombre => 'Veterinarios', :codigo => '2250', :subgrupo_id => 22
OcuOcupaciones.create! :id => 63, :nombre => 'Dentistas', :codigo => '2261', :subgrupo_id => 23
OcuOcupaciones.create! :id => 64, :nombre => 'Farmacéuticos', :codigo => '2262', :subgrupo_id => 23
OcuOcupaciones.create! :id => 65, :nombre => 'Profesionales de la salud y la higiene laboral y ambiental', :codigo => '2263', :subgrupo_id => 23
OcuOcupaciones.create! :id => 66, :nombre => 'Fisioterapeutas ', :codigo => '2264', :subgrupo_id => 23
OcuOcupaciones.create! :id => 67, :nombre => 'Dietistas y nutricionistas', :codigo => '2265', :subgrupo_id => 23
OcuOcupaciones.create! :id => 68, :nombre => 'Audiólogos y logopedas', :codigo => '2266', :subgrupo_id => 23
OcuOcupaciones.create! :id => 69, :nombre => 'Optometristas', :codigo => '2267', :subgrupo_id => 23
OcuOcupaciones.create! :id => 70, :nombre => 'Profesionales de la salud no clasificados bajo otros epígrafes', :codigo => '2269', :subgrupo_id => 23
OcuOcupaciones.create! :id => 71, :nombre => 'Profesores de universidades y de la enseñanza superior', :codigo => '2310', :subgrupo_id => 24
OcuOcupaciones.create! :id => 72, :nombre => 'Profesores de formación profesional', :codigo => '2320', :subgrupo_id => 25
OcuOcupaciones.create! :id => 73, :nombre => 'Profesores de enseñanza secundaria', :codigo => '2330', :subgrupo_id => 26
OcuOcupaciones.create! :id => 74, :nombre => 'Maestros de enseñanza primaria', :codigo => '2341', :subgrupo_id => 27
OcuOcupaciones.create! :id => 75, :nombre => 'Maestros preescolares', :codigo => '2342', :subgrupo_id => 27
OcuOcupaciones.create! :id => 76, :nombre => 'Especialistas en métodos pedagógicos', :codigo => '2351', :subgrupo_id => 28
OcuOcupaciones.create! :id => 77, :nombre => 'Educadores para necesidades especiales', :codigo => '2352', :subgrupo_id => 28
OcuOcupaciones.create! :id => 78, :nombre => 'Otros profesores de idiomas', :codigo => '2353', :subgrupo_id => 28
OcuOcupaciones.create! :id => 79, :nombre => 'Otros profesores de música', :codigo => '2354', :subgrupo_id => 28
OcuOcupaciones.create! :id => 80, :nombre => 'Otros profesores de artes', :codigo => '2355', :subgrupo_id => 28
OcuOcupaciones.create! :id => 81, :nombre => 'Instructores en tecnología de la información', :codigo => '2356', :subgrupo_id => 28
OcuOcupaciones.create! :id => 82, :nombre => 'Profesionales de la enseñanza no clasificados bajo otros epígrafes', :codigo => '2359', :subgrupo_id => 28
OcuOcupaciones.create! :id => 83, :nombre => 'Contables', :codigo => '2411', :subgrupo_id => 29
OcuOcupaciones.create! :id => 84, :nombre => 'Asesores financieros y en inversiones', :codigo => '2412', :subgrupo_id => 29
OcuOcupaciones.create! :id => 85, :nombre => 'Analistas financieros', :codigo => '2413', :subgrupo_id => 29
OcuOcupaciones.create! :id => 86, :nombre => 'Analistas de gestión y organización', :codigo => '2421', :subgrupo_id => 30
OcuOcupaciones.create! :id => 87, :nombre => 'Especialistas en políticas de administración', :codigo => '2422', :subgrupo_id => 30
OcuOcupaciones.create! :id => 88, :nombre => 'Especialistas en políticas y servicios de personal y afines', :codigo => '2423', :subgrupo_id => 30
OcuOcupaciones.create! :id => 89, :nombre => 'Especialistas en formación del personal', :codigo => '2424', :subgrupo_id => 30
OcuOcupaciones.create! :id => 90, :nombre => 'Profesionales de la publicidad y la comercialización', :codigo => '2431', :subgrupo_id => 31
OcuOcupaciones.create! :id => 91, :nombre => 'Profesionales de relaciones públicas', :codigo => '2432', :subgrupo_id => 31
OcuOcupaciones.create! :id => 92, :nombre => 'Profesionales de ventas técnicas y médicas (excluyendo la TIC)', :codigo => '2433', :subgrupo_id => 31
OcuOcupaciones.create! :id => 93, :nombre => 'Profesionales de ventas de tecnología de la información y las comunicaciones', :codigo => '2434', :subgrupo_id => 31
OcuOcupaciones.create! :id => 94, :nombre => 'Analistas de sistemas', :codigo => '2511', :subgrupo_id => 32
OcuOcupaciones.create! :id => 95, :nombre => 'Desarrolladores de software', :codigo => '2512', :subgrupo_id => 32
OcuOcupaciones.create! :id => 96, :nombre => 'Desarrolladores Web y multimedia', :codigo => '2513', :subgrupo_id => 32
OcuOcupaciones.create! :id => 97, :nombre => 'Programadores de aplicaciones', :codigo => '2514', :subgrupo_id => 32
OcuOcupaciones.create! :id => 98, :nombre => 'Desarrolladores y analistas de software y multimedia y analistas no clasificados bajo otros epígrafes', :codigo => '2519', :subgrupo_id => 32
OcuOcupaciones.create! :id => 99, :nombre => 'Diseñadores y administradores de bases de datos', :codigo => '2521', :subgrupo_id => 33
OcuOcupaciones.create! :id => 100, :nombre => 'Administradores de sistemas', :codigo => '2522', :subgrupo_id => 33
OcuOcupaciones.create! :id => 101, :nombre => 'Profesionales en redes de computadores', :codigo => '2523', :subgrupo_id => 33
OcuOcupaciones.create! :id => 102, :nombre => 'Especialistas en bases de datos y en redes de computadores no clasificados bajo otros epígrafes', :codigo => '2529', :subgrupo_id => 33
OcuOcupaciones.create! :id => 103, :nombre => 'Abogados', :codigo => '2611', :subgrupo_id => 34
OcuOcupaciones.create! :id => 104, :nombre => 'Jueces', :codigo => '2612', :subgrupo_id => 34
OcuOcupaciones.create! :id => 105, :nombre => 'Profesionales en derecho no clasificados bajo otros epígrafes', :codigo => '2619', :subgrupo_id => 34
OcuOcupaciones.create! :id => 106, :nombre => 'Archivistas y curadores de museos', :codigo => '2621', :subgrupo_id => 35
OcuOcupaciones.create! :id => 107, :nombre => 'Bibliotecarios, documentalistas y afines', :codigo => '2622', :subgrupo_id => 35
OcuOcupaciones.create! :id => 108, :nombre => 'Economistas', :codigo => '2631', :subgrupo_id => 36
OcuOcupaciones.create! :id => 109, :nombre => 'Sociólogos, antropólogos y afines', :codigo => '2632', :subgrupo_id => 36
OcuOcupaciones.create! :id => 110, :nombre => 'Filósofos, historiadores y especialistas en ciencias políticas', :codigo => '2633', :subgrupo_id => 36
OcuOcupaciones.create! :id => 111, :nombre => 'Psicólogos', :codigo => '2634', :subgrupo_id => 36
OcuOcupaciones.create! :id => 112, :nombre => 'Profesionales del trabajo social', :codigo => '2635', :subgrupo_id => 36
OcuOcupaciones.create! :id => 113, :nombre => 'Profesionales religiosos', :codigo => '2636', :subgrupo_id => 36
OcuOcupaciones.create! :id => 114, :nombre => 'Autores y otros escritores', :codigo => '2641', :subgrupo_id => 37
OcuOcupaciones.create! :id => 115, :nombre => 'Periodistas', :codigo => '2642', :subgrupo_id => 37
OcuOcupaciones.create! :id => 116, :nombre => 'Traductores, intérpretes y lingüistas', :codigo => '2643', :subgrupo_id => 37
OcuOcupaciones.create! :id => 117, :nombre => 'Artistas de artes plásticas', :codigo => '2651', :subgrupo_id => 38
OcuOcupaciones.create! :id => 118, :nombre => 'Músicos, cantantes y compositores', :codigo => '2652', :subgrupo_id => 38
OcuOcupaciones.create! :id => 119, :nombre => 'Bailarines y coreógrafos', :codigo => '2653', :subgrupo_id => 38
OcuOcupaciones.create! :id => 120, :nombre => 'Directores de cine, de teatro y afines', :codigo => '2654', :subgrupo_id => 38
OcuOcupaciones.create! :id => 121, :nombre => 'Actores', :codigo => '2655', :subgrupo_id => 38
OcuOcupaciones.create! :id => 122, :nombre => 'Locutores de radio, televisión y otros medios de comunicación', :codigo => '2656', :subgrupo_id => 38
OcuOcupaciones.create! :id => 123, :nombre => 'Artistas creativos e interpretativos no clasificados bajo otros epígrafes', :codigo => '2659', :subgrupo_id => 38
OcuOcupaciones.create! :id => 124, :nombre => 'Técnicos en ciencias físicas y químicas', :codigo => '3111', :subgrupo_id => 39
OcuOcupaciones.create! :id => 125, :nombre => 'Técnicos en ingeniería civil', :codigo => '3112', :subgrupo_id => 39
OcuOcupaciones.create! :id => 126, :nombre => 'Electrotécnicos', :codigo => '3113', :subgrupo_id => 39
OcuOcupaciones.create! :id => 127, :nombre => 'Técnicos en electrónica', :codigo => '3114', :subgrupo_id => 39
OcuOcupaciones.create! :id => 128, :nombre => 'Técnicos en ingeniería mecánica', :codigo => '3115', :subgrupo_id => 39
OcuOcupaciones.create! :id => 129, :nombre => 'Técnicos en química industrial', :codigo => '3116', :subgrupo_id => 39
OcuOcupaciones.create! :id => 130, :nombre => 'Técnicos en ingeniería de minas y metalurgia', :codigo => '3117', :subgrupo_id => 39
OcuOcupaciones.create! :id => 131, :nombre => 'Delineantes y dibujantes técnicos', :codigo => '3118', :subgrupo_id => 39
OcuOcupaciones.create! :id => 132, :nombre => 'Técnicos en ciencias físicas y en ingeniería no clasificados bajo otros epígrafes', :codigo => '3119', :subgrupo_id => 39
OcuOcupaciones.create! :id => 133, :nombre => 'Supervisores en ingeniería de minas', :codigo => '3121', :subgrupo_id => 40
OcuOcupaciones.create! :id => 134, :nombre => 'Supervisores de industrias manufactureras', :codigo => '3122', :subgrupo_id => 40
OcuOcupaciones.create! :id => 135, :nombre => 'Supervisores de la construcción', :codigo => '3123', :subgrupo_id => 40
OcuOcupaciones.create! :id => 136, :nombre => 'Operadores de instalaciones de producción de energía', :codigo => '3131', :subgrupo_id => 41
OcuOcupaciones.create! :id => 137, :nombre => 'Operadores de incineradores, instalaciones de tratamiento de agua y afines', :codigo => '3132', :subgrupo_id => 41
OcuOcupaciones.create! :id => 138, :nombre => 'Controladores de instalaciones de procesamiento de productos químicos', :codigo => '3133', :subgrupo_id => 41
OcuOcupaciones.create! :id => 139, :nombre => 'Operadores de instalaciones de refinación de petróleo y gas natural', :codigo => '3134', :subgrupo_id => 41
OcuOcupaciones.create! :id => 140, :nombre => 'Controladores de procesos de producción de metales', :codigo => '3135', :subgrupo_id => 41
OcuOcupaciones.create! :id => 141, :nombre => 'Técnicos en control de procesos no clasificados bajo otros epígrafes', :codigo => '3139', :subgrupo_id => 41
OcuOcupaciones.create! :id => 142, :nombre => 'Técnicos en ciencias biológicas (excluyendo la medicina)', :codigo => '3141', :subgrupo_id => 42
OcuOcupaciones.create! :id => 143, :nombre => 'Técnicos agropecuarios', :codigo => '3142', :subgrupo_id => 42
OcuOcupaciones.create! :id => 144, :nombre => 'Técnicos forestales', :codigo => '3143', :subgrupo_id => 42
OcuOcupaciones.create! :id => 145, :nombre => 'Oficiales maquinistas en navegación', :codigo => '3151', :subgrupo_id => 43
OcuOcupaciones.create! :id => 146, :nombre => 'Capitanes, oficiales de cubierta y prácticos', :codigo => '3152', :subgrupo_id => 43
OcuOcupaciones.create! :id => 147, :nombre => 'Pilotos de aviación y afines', :codigo => '3153', :subgrupo_id => 43
OcuOcupaciones.create! :id => 148, :nombre => 'Controladores de tráfico aéreo', :codigo => '3154', :subgrupo_id => 43
OcuOcupaciones.create! :id => 149, :nombre => 'Técnicos en seguridad aeronáutica', :codigo => '3155', :subgrupo_id => 43
OcuOcupaciones.create! :id => 150, :nombre => 'Técnicos en aparatos de diagnóstico y tratamiento médico', :codigo => '3211', :subgrupo_id => 44
OcuOcupaciones.create! :id => 151, :nombre => 'Técnicos de laboratorios médicos', :codigo => '3212', :subgrupo_id => 44
OcuOcupaciones.create! :id => 152, :nombre => 'Técnicos y asistentes farmacéuticos', :codigo => '3213', :subgrupo_id => 44
OcuOcupaciones.create! :id => 153, :nombre => 'Técnicos de prótesis médicas y dentales', :codigo => '3214', :subgrupo_id => 44
OcuOcupaciones.create! :id => 154, :nombre => 'Profesionales de nivel medio de enfermería', :codigo => '3221', :subgrupo_id => 45
OcuOcupaciones.create! :id => 155, :nombre => 'Profesionales de nivel medio de partería', :codigo => '3222', :subgrupo_id => 45
OcuOcupaciones.create! :id => 156, :nombre => 'Profesionales de nivel medio de medicina tradicional y alternativa', :codigo => '3230', :subgrupo_id => 46
OcuOcupaciones.create! :id => 157, :nombre => 'Técnicos y asistentes veterinarios', :codigo => '3240', :subgrupo_id => 47
OcuOcupaciones.create! :id => 158, :nombre => 'Dentistas auxiliares y ayudantes de odontología', :codigo => '3251', :subgrupo_id => 48
OcuOcupaciones.create! :id => 159, :nombre => 'Técnicos en documentación sanitaria', :codigo => '3252', :subgrupo_id => 48
OcuOcupaciones.create! :id => 160, :nombre => 'Trabajadores comunitarios de la salud', :codigo => '3253', :subgrupo_id => 48
OcuOcupaciones.create! :id => 161, :nombre => 'Técnicos en optometría y ópticos', :codigo => '3254', :subgrupo_id => 48
OcuOcupaciones.create! :id => 162, :nombre => 'Técnicos y asistentes fisioterapeutas', :codigo => '3255', :subgrupo_id => 48
OcuOcupaciones.create! :id => 163, :nombre => 'Practicantes y asistentes médicos', :codigo => '3256', :subgrupo_id => 48
OcuOcupaciones.create! :id => 164, :nombre => 'Inspectores de la salud laboral,  medioambiental y afines', :codigo => '3257', :subgrupo_id => 48
OcuOcupaciones.create! :id => 165, :nombre => 'Ayudantes de ambulancias', :codigo => '3258', :subgrupo_id => 48
OcuOcupaciones.create! :id => 166, :nombre => 'Profesionales de la salud de nivel medio no clasificados bajo otros epígrafes', :codigo => '3259', :subgrupo_id => 48
OcuOcupaciones.create! :id => 167, :nombre => 'Agentes de bolsa, cambio y otros servicios financieros', :codigo => '3311', :subgrupo_id => 49
OcuOcupaciones.create! :id => 168, :nombre => 'Oficiales de préstamos y créditos', :codigo => '3312', :subgrupo_id => 49
OcuOcupaciones.create! :id => 169, :nombre => 'Tenedores de libros', :codigo => '3313', :subgrupo_id => 49
OcuOcupaciones.create! :id => 170, :nombre => 'Profesionales de nivel medio de servicios estadísticos, matemáticos y afines', :codigo => '3314', :subgrupo_id => 49
OcuOcupaciones.create! :id => 171, :nombre => 'Tasadores', :codigo => '3315', :subgrupo_id => 49
OcuOcupaciones.create! :id => 172, :nombre => 'Agentes de seguros', :codigo => '3321', :subgrupo_id => 50
OcuOcupaciones.create! :id => 173, :nombre => 'Representantes comerciales', :codigo => '3322', :subgrupo_id => 50
OcuOcupaciones.create! :id => 174, :nombre => 'Agentes de compras', :codigo => '3323', :subgrupo_id => 50
OcuOcupaciones.create! :id => 175, :nombre => 'Agentes de compras y consignatarios', :codigo => '3324', :subgrupo_id => 50
OcuOcupaciones.create! :id => 176, :nombre => 'Declarantes o gestores de aduana', :codigo => '3331', :subgrupo_id => 51
OcuOcupaciones.create! :id => 177, :nombre => 'Organizadores de conferencias y eventos', :codigo => '3332', :subgrupo_id => 51
OcuOcupaciones.create! :id => 178, :nombre => 'Agentes de empleo y contratistas de mano de obra', :codigo => '3333', :subgrupo_id => 51
OcuOcupaciones.create! :id => 179, :nombre => 'Agentes inmobiliarios', :codigo => '3334', :subgrupo_id => 51
OcuOcupaciones.create! :id => 180, :nombre => 'Agentes de servicios comerciales no clasificados bajo otros epígrafes', :codigo => '3339', :subgrupo_id => 51
OcuOcupaciones.create! :id => 181, :nombre => 'Supervisores de secretaría', :codigo => '3341', :subgrupo_id => 52
OcuOcupaciones.create! :id => 182, :nombre => 'Secretarios jurídicos', :codigo => '3342', :subgrupo_id => 52
OcuOcupaciones.create! :id => 183, :nombre => 'Secretarios administrativos y ejecutivos', :codigo => '3343', :subgrupo_id => 52
OcuOcupaciones.create! :id => 184, :nombre => 'Secretarios médicos', :codigo => '3344', :subgrupo_id => 52
OcuOcupaciones.create! :id => 185, :nombre => 'Agentes de aduana e inspectores de fronteras', :codigo => '3351', :subgrupo_id => 53
OcuOcupaciones.create! :id => 186, :nombre => 'Agentes de administración tributaria', :codigo => '3352', :subgrupo_id => 53
OcuOcupaciones.create! :id => 187, :nombre => 'Agentes de servicios de seguridad social', :codigo => '3353', :subgrupo_id => 53
OcuOcupaciones.create! :id => 188, :nombre => 'Agentes de servicios de expedición de licencias y permisos', :codigo => '3354', :subgrupo_id => 53
OcuOcupaciones.create! :id => 189, :nombre => 'Inspectores de policía y detectives', :codigo => '3355', :subgrupo_id => 53
OcuOcupaciones.create! :id => 190, :nombre => 'Agentes de la administración pública para la aplicacion de la ley y afines no clasificados bajo otros epígrafes', :codigo => '3359', :subgrupo_id => 53
OcuOcupaciones.create! :id => 191, :nombre => 'Profesionales de nivel medio del derecho y servicios legales y afines', :codigo => '3411', :subgrupo_id => 54
OcuOcupaciones.create! :id => 192, :nombre => 'Trabajadores y asistentes sociales de nivel medio', :codigo => '3412', :subgrupo_id => 54
OcuOcupaciones.create! :id => 193, :nombre => 'Auxiliares laicos de las religiones', :codigo => '3413', :subgrupo_id => 54
OcuOcupaciones.create! :id => 194, :nombre => 'Atletas y deportistas', :codigo => '3421', :subgrupo_id => 55
OcuOcupaciones.create! :id => 195, :nombre => 'Entrenadores, instructores y árbitros de actividades deportivas', :codigo => '3422', :subgrupo_id => 55
OcuOcupaciones.create! :id => 196, :nombre => 'Instructores de educación física y actividades recreativas', :codigo => '3423', :subgrupo_id => 55
OcuOcupaciones.create! :id => 197, :nombre => 'Fotógrafos', :codigo => '3431', :subgrupo_id => 56
OcuOcupaciones.create! :id => 198, :nombre => 'Diseñadores y decoradores de interior', :codigo => '3432', :subgrupo_id => 56
OcuOcupaciones.create! :id => 199, :nombre => 'Técnicos en galerías de arte, museos y bibliotecas', :codigo => '3433', :subgrupo_id => 56
OcuOcupaciones.create! :id => 200, :nombre => 'Chefs', :codigo => '3434', :subgrupo_id => 56
OcuOcupaciones.create! :id => 201, :nombre => 'Otros profesionales de nivel medio en actividades culturales y artísticas', :codigo => '3435', :subgrupo_id => 56
OcuOcupaciones.create! :id => 202, :nombre => 'Técnicos en operaciones de tecnología de la información y las comunicaciones', :codigo => '3511', :subgrupo_id => 57
OcuOcupaciones.create! :id => 203, :nombre => 'Técnicos en asistencia al usuario de tecnología de la información y las comunicaciones', :codigo => '3512', :subgrupo_id => 57
OcuOcupaciones.create! :id => 204, :nombre => 'Técnicos en redes y sistemas de computadores', :codigo => '3513', :subgrupo_id => 57
OcuOcupaciones.create! :id => 205, :nombre => 'Técnicos de la Web', :codigo => '3514', :subgrupo_id => 57
OcuOcupaciones.create! :id => 206, :nombre => 'Técnicos de radiodifusión y grabación audio visual', :codigo => '3521', :subgrupo_id => 58
OcuOcupaciones.create! :id => 207, :nombre => 'Técnicos de ingeniería de las telecomunicaciones', :codigo => '3522', :subgrupo_id => 58
OcuOcupaciones.create! :id => 208, :nombre => 'Oficinistas generales', :codigo => '4110', :subgrupo_id => 59
OcuOcupaciones.create! :id => 209, :nombre => 'Secretarios (general)', :codigo => '4120', :subgrupo_id => 60
OcuOcupaciones.create! :id => 210, :nombre => 'Operadores de máquinas de procesamiento de texto y mecanógrafos', :codigo => '4131', :subgrupo_id => 61
OcuOcupaciones.create! :id => 211, :nombre => 'Grabadores de datos', :codigo => '4132', :subgrupo_id => 61
OcuOcupaciones.create! :id => 212, :nombre => 'Cajeros de bancos y afines', :codigo => '4211', :subgrupo_id => 62
OcuOcupaciones.create! :id => 213, :nombre => 'Receptores de apuestas y afines', :codigo => '4212', :subgrupo_id => 62
OcuOcupaciones.create! :id => 214, :nombre => 'Prestamistas', :codigo => '4213', :subgrupo_id => 62
OcuOcupaciones.create! :id => 215, :nombre => 'Cobradores y afines', :codigo => '4214', :subgrupo_id => 62
OcuOcupaciones.create! :id => 216, :nombre => 'Empleados de agencias de viajes', :codigo => '4221', :subgrupo_id => 63
OcuOcupaciones.create! :id => 217, :nombre => 'Empleados de centros de llamadas', :codigo => '4222', :subgrupo_id => 63
OcuOcupaciones.create! :id => 218, :nombre => 'Telefonistas', :codigo => '4223', :subgrupo_id => 63
OcuOcupaciones.create! :id => 219, :nombre => 'Recepcionistas de hoteles', :codigo => '4224', :subgrupo_id => 63
OcuOcupaciones.create! :id => 220, :nombre => 'Empleados de ventanillas de informaciones', :codigo => '4225', :subgrupo_id => 63
OcuOcupaciones.create! :id => 221, :nombre => 'Recepcionistas (general)', :codigo => '4226', :subgrupo_id => 63
OcuOcupaciones.create! :id => 222, :nombre => 'Entrevistadores de encuestas y de investigaciones de mercados', :codigo => '4227', :subgrupo_id => 63
OcuOcupaciones.create! :id => 223, :nombre => 'Empleados de servicios de información al cliente no clasificados bajo otros epígrafes', :codigo => '4229', :subgrupo_id => 63
OcuOcupaciones.create! :id => 224, :nombre => 'Empleados de contabilidad y cálculo de costos', :codigo => '4311', :subgrupo_id => 64
OcuOcupaciones.create! :id => 225, :nombre => 'Empleados de servicios estadísticos, financieros y de seguros', :codigo => '4312', :subgrupo_id => 64
OcuOcupaciones.create! :id => 226, :nombre => 'Empleados encargados de las nóminas', :codigo => '4313', :subgrupo_id => 64
OcuOcupaciones.create! :id => 227, :nombre => 'Empleados de control de abastecimientos e inventario', :codigo => '4321', :subgrupo_id => 65
OcuOcupaciones.create! :id => 228, :nombre => 'Empleados de servicios de apoyo a la producción', :codigo => '4322', :subgrupo_id => 65
OcuOcupaciones.create! :id => 229, :nombre => 'Empleados de servicios de transporte', :codigo => '4323', :subgrupo_id => 65
OcuOcupaciones.create! :id => 230, :nombre => 'Empleados de bibliotecas', :codigo => '4411', :subgrupo_id => 66
OcuOcupaciones.create! :id => 231, :nombre => 'Empleados de servicios de correos', :codigo => '4412', :subgrupo_id => 66
OcuOcupaciones.create! :id => 232, :nombre => 'Codificadores de datos, correctores de pruebas de imprenta y afines', :codigo => '4413', :subgrupo_id => 66
OcuOcupaciones.create! :id => 233, :nombre => 'Escribientes públicos y afines', :codigo => '4414', :subgrupo_id => 66
OcuOcupaciones.create! :id => 234, :nombre => 'Empleados de archivos', :codigo => '4415', :subgrupo_id => 66
OcuOcupaciones.create! :id => 235, :nombre => 'Empleados del servicio de personal', :codigo => '4416', :subgrupo_id => 66
OcuOcupaciones.create! :id => 236, :nombre => 'Personal de apoyo administrativo no clasificado bajo otros epígrafes', :codigo => '4419', :subgrupo_id => 66
OcuOcupaciones.create! :id => 237, :nombre => 'Auxiliares de servicio de abordo', :codigo => '5111', :subgrupo_id => 67
OcuOcupaciones.create! :id => 238, :nombre => 'Revisores y cobradores de los transportes públicos', :codigo => '5112', :subgrupo_id => 67
OcuOcupaciones.create! :id => 239, :nombre => 'Guías de turismo', :codigo => '5113', :subgrupo_id => 67
OcuOcupaciones.create! :id => 240, :nombre => 'Cocineros', :codigo => '5120', :subgrupo_id => 68
OcuOcupaciones.create! :id => 241, :nombre => 'Camareros de mesas', :codigo => '5131', :subgrupo_id => 69
OcuOcupaciones.create! :id => 242, :nombre => 'Camareros de barra', :codigo => '5132', :subgrupo_id => 69
OcuOcupaciones.create! :id => 243, :nombre => 'Peluqueros', :codigo => '5141', :subgrupo_id => 70
OcuOcupaciones.create! :id => 244, :nombre => 'Especialistas en tratamientos de belleza y afines', :codigo => '5142', :subgrupo_id => 70
OcuOcupaciones.create! :id => 245, :nombre => 'Supervisores de mantenimiento y limpieza en oficinas, hoteles y otros establecimientos', :codigo => '5151', :subgrupo_id => 71
OcuOcupaciones.create! :id => 246, :nombre => 'Ecónomos y mayordomos domésticos ', :codigo => '5152', :subgrupo_id => 71
OcuOcupaciones.create! :id => 247, :nombre => 'Conserjes', :codigo => '5153', :subgrupo_id => 71
OcuOcupaciones.create! :id => 248, :nombre => 'Astrólogos, adivinadores y afines', :codigo => '5161', :subgrupo_id => 72
OcuOcupaciones.create! :id => 249, :nombre => 'Acompañantes y ayudantes de cámara', :codigo => '5162', :subgrupo_id => 72
OcuOcupaciones.create! :id => 250, :nombre => 'Personal de pompas fúnebres y embalsamadores', :codigo => '5163', :subgrupo_id => 72
OcuOcupaciones.create! :id => 251, :nombre => 'Cuidadores de animales', :codigo => '5164', :subgrupo_id => 72
OcuOcupaciones.create! :id => 252, :nombre => 'Instructores de autoescuela', :codigo => '5165', :subgrupo_id => 72
OcuOcupaciones.create! :id => 253, :nombre => 'Trabajadores de servicios personales no clasificados bajo otros epígrafes', :codigo => '5169', :subgrupo_id => 72
OcuOcupaciones.create! :id => 254, :nombre => 'Vendedores de quioscos y de puestos de mercado', :codigo => '5211', :subgrupo_id => 73
OcuOcupaciones.create! :id => 255, :nombre => 'Vendedores ambulantes de productos comestibles', :codigo => '5212', :subgrupo_id => 73
OcuOcupaciones.create! :id => 256, :nombre => 'Comerciantes de tiendas', :codigo => '5221', :subgrupo_id => 74
OcuOcupaciones.create! :id => 257, :nombre => 'Supervisores de tiendas y almacenes', :codigo => '5222', :subgrupo_id => 74
OcuOcupaciones.create! :id => 258, :nombre => 'Asistentes de venta de tiendas y almacenes', :codigo => '5223', :subgrupo_id => 74
OcuOcupaciones.create! :id => 259, :nombre => 'Cajeros y expendedores de billetes', :codigo => '5230', :subgrupo_id => 75
OcuOcupaciones.create! :id => 260, :nombre => 'Modelos de moda, arte y publicidad', :codigo => '5241', :subgrupo_id => 76
OcuOcupaciones.create! :id => 261, :nombre => 'Demostradores de tiendas', :codigo => '5242', :subgrupo_id => 76
OcuOcupaciones.create! :id => 262, :nombre => 'Vendedores puerta a puerta', :codigo => '5243', :subgrupo_id => 76
OcuOcupaciones.create! :id => 263, :nombre => 'Vendedores por teléfono', :codigo => '5244', :subgrupo_id => 76
OcuOcupaciones.create! :id => 264, :nombre => 'Expendedores de gasolineras', :codigo => '5245', :subgrupo_id => 76
OcuOcupaciones.create! :id => 265, :nombre => 'Vendedores de comidas al mostrador', :codigo => '5246', :subgrupo_id => 76
OcuOcupaciones.create! :id => 266, :nombre => 'Vendedores no clasificados bajo otros epígrafes', :codigo => '5249', :subgrupo_id => 76
OcuOcupaciones.create! :id => 267, :nombre => 'Cuidadores de niños', :codigo => '5311', :subgrupo_id => 77
OcuOcupaciones.create! :id => 268, :nombre => 'Auxiliares de maestros', :codigo => '5312', :subgrupo_id => 77
OcuOcupaciones.create! :id => 269, :nombre => 'Trabajadores de los cuidados personales en instituciones', :codigo => '5321', :subgrupo_id => 78
OcuOcupaciones.create! :id => 270, :nombre => 'Trabajadores de los cuidados personales a domicilio', :codigo => '5322', :subgrupo_id => 78
OcuOcupaciones.create! :id => 271, :nombre => 'Trabajadores de los cuidados personales en servicios de salud no clasificados bajo otros epígrafes', :codigo => '5329', :subgrupo_id => 78
OcuOcupaciones.create! :id => 272, :nombre => 'Bomberos', :codigo => '5411', :subgrupo_id => 79
OcuOcupaciones.create! :id => 273, :nombre => 'Policías', :codigo => '5412', :subgrupo_id => 79
OcuOcupaciones.create! :id => 274, :nombre => 'Guardianes de prisión', :codigo => '5413', :subgrupo_id => 79
OcuOcupaciones.create! :id => 275, :nombre => 'Guardias de protección', :codigo => '5414', :subgrupo_id => 79
OcuOcupaciones.create! :id => 276, :nombre => 'Personal de los servicios de protección no clasificados bajo otros epígrafes', :codigo => '5419', :subgrupo_id => 79
OcuOcupaciones.create! :id => 277, :nombre => 'Agricultores y trabajadores calificados de cultivos extensivos', :codigo => '6111', :subgrupo_id => 80
OcuOcupaciones.create! :id => 278, :nombre => 'Agricultores y trabajadores calificados de plantaciones de árboles y arbustos', :codigo => '6112', :subgrupo_id => 80
OcuOcupaciones.create! :id => 279, :nombre => 'Agricultores y trabajadores calificados de huertas, invernaderos, viveros y jardines', :codigo => '6113', :subgrupo_id => 80
OcuOcupaciones.create! :id => 280, :nombre => 'Agricultores y trabajadores calificados de cultivos mixtos', :codigo => '6114', :subgrupo_id => 80
OcuOcupaciones.create! :id => 281, :nombre => 'Criadores de ganado', :codigo => '6121', :subgrupo_id => 81
OcuOcupaciones.create! :id => 282, :nombre => 'Avicultores y trabajadores calificados de la avicultura', :codigo => '6122', :subgrupo_id => 81
OcuOcupaciones.create! :id => 283, :nombre => 'Apicultores y sericultores y trabajadores calificados de la apicultura y la sericultura', :codigo => '6123', :subgrupo_id => 81
OcuOcupaciones.create! :id => 284, :nombre => 'Criadores y trabajadores pecuarios calificados de la cría de animales no clasificados bajo otros epígrafes', :codigo => '6129', :subgrupo_id => 81
OcuOcupaciones.create! :id => 285, :nombre => 'Productores y trabajadores calificados de explotaciones agropecuarias mixtas cuya producción se destina al mercado', :codigo => '6130', :subgrupo_id => 82
OcuOcupaciones.create! :id => 286, :nombre => 'Trabajadores forestales calificados y afines', :codigo => '6210', :subgrupo_id => 83
OcuOcupaciones.create! :id => 287, :nombre => 'Trabajadores de explotaciones de acuicultura', :codigo => '6221', :subgrupo_id => 84
OcuOcupaciones.create! :id => 288, :nombre => 'Pescadores de agua dulce y en aguas costeras', :codigo => '6222', :subgrupo_id => 84
OcuOcupaciones.create! :id => 289, :nombre => 'Pescadores de alta mar', :codigo => '6223', :subgrupo_id => 84
OcuOcupaciones.create! :id => 290, :nombre => 'Cazadores y tramperos', :codigo => '6224', :subgrupo_id => 84
OcuOcupaciones.create! :id => 291, :nombre => 'Trabajadores agrícolas de subsistencia', :codigo => '6310', :subgrupo_id => 85
OcuOcupaciones.create! :id => 292, :nombre => 'Trabajadores pecuarios de subsistencia', :codigo => '6320', :subgrupo_id => 86
OcuOcupaciones.create! :id => 293, :nombre => 'Trabajadores agropecuarios de subsistencia', :codigo => '6330', :subgrupo_id => 87
OcuOcupaciones.create! :id => 294, :nombre => 'Pescadores, cazadores, tramperos y recolectores de subsistencia', :codigo => '6340', :subgrupo_id => 88
OcuOcupaciones.create! :id => 295, :nombre => 'Constructores de casas', :codigo => '7111', :subgrupo_id => 89
OcuOcupaciones.create! :id => 296, :nombre => 'Albañiles', :codigo => '7112', :subgrupo_id => 89
OcuOcupaciones.create! :id => 297, :nombre => 'Mamposteros, tronzadores, labrantes y grabadores de piedra', :codigo => '7113', :subgrupo_id => 89
OcuOcupaciones.create! :id => 298, :nombre => 'Operarios en cemento armado, enfoscadores y afines', :codigo => '7114', :subgrupo_id => 89
OcuOcupaciones.create! :id => 299, :nombre => 'Carpinteros de armar y de obra blanca', :codigo => '7115', :subgrupo_id => 89
OcuOcupaciones.create! :id => 300, :nombre => 'Oficiales y operarios de la construcción (obra gruesa) y afines no clasificados bajo otros epígrafes', :codigo => '7119', :subgrupo_id => 89
OcuOcupaciones.create! :id => 301, :nombre => 'Techadores', :codigo => '7121', :subgrupo_id => 90
OcuOcupaciones.create! :id => 302, :nombre => 'Parqueteros y colocadores de suelos', :codigo => '7122', :subgrupo_id => 90
OcuOcupaciones.create! :id => 303, :nombre => 'Revocadores', :codigo => '7123', :subgrupo_id => 90
OcuOcupaciones.create! :id => 304, :nombre => 'Instaladores de material aislante y de insonorización', :codigo => '7124', :subgrupo_id => 90
OcuOcupaciones.create! :id => 305, :nombre => 'Cristaleros', :codigo => '7125', :subgrupo_id => 90
OcuOcupaciones.create! :id => 306, :nombre => 'Fontaneros e instaladores de tuberías', :codigo => '7126', :subgrupo_id => 90
OcuOcupaciones.create! :id => 307, :nombre => 'Mecánicos-montadores de instalaciones de refrigeración y climatización', :codigo => '7127', :subgrupo_id => 90
OcuOcupaciones.create! :id => 308, :nombre => 'Pintores y empapeladores', :codigo => '7131', :subgrupo_id => 91
OcuOcupaciones.create! :id => 309, :nombre => 'Barnizadores y afines', :codigo => '7132', :subgrupo_id => 91
OcuOcupaciones.create! :id => 310, :nombre => 'Limpiadores de fachadas y deshollinadores', :codigo => '7133', :subgrupo_id => 91
OcuOcupaciones.create! :id => 311, :nombre => 'Moldeadores y macheros', :codigo => '7211', :subgrupo_id => 92
OcuOcupaciones.create! :id => 312, :nombre => 'Soldadores y oxicortadores', :codigo => '7212', :subgrupo_id => 92
OcuOcupaciones.create! :id => 313, :nombre => 'Chapistas y caldereros', :codigo => '7213', :subgrupo_id => 92
OcuOcupaciones.create! :id => 314, :nombre => 'Montadores de estructuras metálicas', :codigo => '7214', :subgrupo_id => 92
OcuOcupaciones.create! :id => 315, :nombre => 'Aparejadores y empalmadores de cables', :codigo => '7215', :subgrupo_id => 92
OcuOcupaciones.create! :id => 316, :nombre => 'Herreros y forjadores', :codigo => '7221', :subgrupo_id => 93
OcuOcupaciones.create! :id => 317, :nombre => 'Herramentistas y afines', :codigo => '7222', :subgrupo_id => 93
OcuOcupaciones.create! :id => 318, :nombre => 'Reguladores y operadores de máquinas herramientas', :codigo => '7223', :subgrupo_id => 93
OcuOcupaciones.create! :id => 319, :nombre => 'Pulidores de metales y afiladores de herramientas', :codigo => '7224', :subgrupo_id => 93
OcuOcupaciones.create! :id => 320, :nombre => 'Mecánicos y reparadores de vehículos de motor', :codigo => '7231', :subgrupo_id => 94
OcuOcupaciones.create! :id => 321, :nombre => 'Mecánicos y reparadores de motores de avión', :codigo => '7232', :subgrupo_id => 94
OcuOcupaciones.create! :id => 322, :nombre => 'Mecánicos y reparadores de máquinas agrícolas e industriales', :codigo => '7233', :subgrupo_id => 94
OcuOcupaciones.create! :id => 323, :nombre => 'Reparadores de bicicletas y afines', :codigo => '7234', :subgrupo_id => 94
OcuOcupaciones.create! :id => 324, :nombre => 'Mecánicos y reparadores de instrumentos de precisión', :codigo => '7311', :subgrupo_id => 95
OcuOcupaciones.create! :id => 325, :nombre => 'Fabricantes y afinadores de instrumentos musicales', :codigo => '7312', :subgrupo_id => 95
OcuOcupaciones.create! :id => 326, :nombre => 'Joyeros, orfebres y plateros', :codigo => '7313', :subgrupo_id => 95
OcuOcupaciones.create! :id => 327, :nombre => 'Alfareros y afines (barro, arcilla y abrasivos)', :codigo => '7314', :subgrupo_id => 95
OcuOcupaciones.create! :id => 328, :nombre => 'Sopladores, modeladores, laminadores, cortadores y pulidores de vidrio', :codigo => '7315', :subgrupo_id => 95
OcuOcupaciones.create! :id => 329, :nombre => 'Redactores de carteles, pintores decorativos y grabadores', :codigo => '7316', :subgrupo_id => 95
OcuOcupaciones.create! :id => 330, :nombre => 'Artesanos en madera, cestería y materiales similares', :codigo => '7317', :subgrupo_id => 95
OcuOcupaciones.create! :id => 331, :nombre => 'Artesanos de los tejidos, el cuero y materiales similares', :codigo => '7318', :subgrupo_id => 95
OcuOcupaciones.create! :id => 332, :nombre => 'Artesanos no clasificados bajo otros epígrafes', :codigo => '7319', :subgrupo_id => 95
OcuOcupaciones.create! :id => 333, :nombre => 'Cajistas, tipógrafos y afines', :codigo => '7321', :subgrupo_id => 96
OcuOcupaciones.create! :id => 334, :nombre => 'Impresores', :codigo => '7322', :subgrupo_id => 96
OcuOcupaciones.create! :id => 335, :nombre => 'Encuadernadores y afines', :codigo => '7323', :subgrupo_id => 96
OcuOcupaciones.create! :id => 336, :nombre => 'Electricistas de obras y afines', :codigo => '7411', :subgrupo_id => 97
OcuOcupaciones.create! :id => 337, :nombre => 'Mecánicos y ajustadores electricistas', :codigo => '7412', :subgrupo_id => 97
OcuOcupaciones.create! :id => 338, :nombre => 'Instaladores y reparadores de líneas eléctricas ', :codigo => '7413', :subgrupo_id => 97
OcuOcupaciones.create! :id => 339, :nombre => 'Mecánicos y reparadores en electrónica', :codigo => '7421', :subgrupo_id => 98
OcuOcupaciones.create! :id => 340, :nombre => 'Instaladores y reparadores en tecnología de la información y las comunicaciones', :codigo => '7422', :subgrupo_id => 98
OcuOcupaciones.create! :id => 341, :nombre => 'Carniceros, pescaderos y afines', :codigo => '7511', :subgrupo_id => 99
OcuOcupaciones.create! :id => 342, :nombre => 'Panaderos, pasteleros y confiteros', :codigo => '7512', :subgrupo_id => 99
OcuOcupaciones.create! :id => 343, :nombre => 'Operarios de la elaboración de productos lácteos', :codigo => '7513', :subgrupo_id => 99
OcuOcupaciones.create! :id => 344, :nombre => 'Operarios de la conservación de frutas, legumbres, verduras y afines', :codigo => '7514', :subgrupo_id => 99
OcuOcupaciones.create! :id => 345, :nombre => 'Catadores y clasificadores de alimentos y bebidas', :codigo => '7515', :subgrupo_id => 99
OcuOcupaciones.create! :id => 346, :nombre => 'Preparadores y elaboradores de tabaco y sus productos', :codigo => '7516', :subgrupo_id => 99
OcuOcupaciones.create! :id => 347, :nombre => 'Operarios del tratamiento de la madera', :codigo => '7521', :subgrupo_id => 100
OcuOcupaciones.create! :id => 348, :nombre => 'Ebanistas y afines', :codigo => '7522', :subgrupo_id => 100
OcuOcupaciones.create! :id => 349, :nombre => 'Reguladores y operadores de máquinas de labrar madera', :codigo => '7523', :subgrupo_id => 100
OcuOcupaciones.create! :id => 350, :nombre => 'Sastres, modistos, peleteros y sombrereros', :codigo => '7531', :subgrupo_id => 101
OcuOcupaciones.create! :id => 351, :nombre => 'Patronistas y cortadores de tela y afines', :codigo => '7532', :subgrupo_id => 101
OcuOcupaciones.create! :id => 352, :nombre => 'Costureros, bordadores y afines', :codigo => '7533', :subgrupo_id => 101
OcuOcupaciones.create! :id => 353, :nombre => 'Tapiceros, colchoneros y afines', :codigo => '7534', :subgrupo_id => 101
OcuOcupaciones.create! :id => 354, :nombre => 'Apelambradores, pellejeros y curtidores', :codigo => '7535', :subgrupo_id => 101
OcuOcupaciones.create! :id => 355, :nombre => 'Zapateros y afines', :codigo => '7536', :subgrupo_id => 101
OcuOcupaciones.create! :id => 356, :nombre => 'Buzos', :codigo => '7541', :subgrupo_id => 102
OcuOcupaciones.create! :id => 357, :nombre => 'Dinamiteros y pegadores', :codigo => '7542', :subgrupo_id => 102
OcuOcupaciones.create! :id => 358, :nombre => 'Clasificadores y probadores de productos (excluyendo alimentos y bebidas)', :codigo => '7543', :subgrupo_id => 102
OcuOcupaciones.create! :id => 359, :nombre => 'Fumigadores y otros controladores de plagas y malas hierbas', :codigo => '7544', :subgrupo_id => 102
OcuOcupaciones.create! :id => 360, :nombre => 'Oficiales, operarios y artesanos de artes mecánicas y de otros oficios no clasificados bajo otros epígrafes', :codigo => '7549', :subgrupo_id => 102
OcuOcupaciones.create! :id => 361, :nombre => 'Mineros y operadores de instalaciones mineras', :codigo => '8111', :subgrupo_id => 103
OcuOcupaciones.create! :id => 362, :nombre => 'Operadores de instalaciones de procesamiento de minerales y rocas', :codigo => '8112', :subgrupo_id => 103
OcuOcupaciones.create! :id => 363, :nombre => 'Perforadores y sondistas de pozos y afines', :codigo => '8113', :subgrupo_id => 103
OcuOcupaciones.create! :id => 364, :nombre => 'Operadores de máquinas para fabricar cemento y otros productos minerales', :codigo => '8114', :subgrupo_id => 103
OcuOcupaciones.create! :id => 365, :nombre => 'Operadores de instalaciones de procesamiento de metales', :codigo => '8121', :subgrupo_id => 104
OcuOcupaciones.create! :id => 366, :nombre => 'Operadores de máquinas pulidoras, galvanizadoras y recubridoras de metales ', :codigo => '8122', :subgrupo_id => 104
OcuOcupaciones.create! :id => 367, :nombre => 'Operadores de plantas y máquinas de productos químicos', :codigo => '8131', :subgrupo_id => 105
OcuOcupaciones.create! :id => 368, :nombre => 'Operadores de máquinas para fabricar productos fotográficos', :codigo => '8132', :subgrupo_id => 105
OcuOcupaciones.create! :id => 369, :nombre => 'Operadores de máquinas para fabricar productos de caucho', :codigo => '8141', :subgrupo_id => 106
OcuOcupaciones.create! :id => 370, :nombre => 'Operadores de máquinas para fabricar productos de material plástico', :codigo => '8142', :subgrupo_id => 106
OcuOcupaciones.create! :id => 371, :nombre => 'Operadores de máquinas para fabricar productos de papel', :codigo => '8143', :subgrupo_id => 106
OcuOcupaciones.create! :id => 372, :nombre => 'Operadores de máquinas de preparación de fibras, hilado y devanado', :codigo => '8151', :subgrupo_id => 107
OcuOcupaciones.create! :id => 373, :nombre => 'Operadores de telares y otras máquinas tejedoras', :codigo => '8152', :subgrupo_id => 107
OcuOcupaciones.create! :id => 374, :nombre => 'Operadores de máquinas de coser', :codigo => '8153', :subgrupo_id => 107
OcuOcupaciones.create! :id => 375, :nombre => 'Operadores de máquinas de blanqueamiento, teñido y limpieza de tejidos', :codigo => '8154', :subgrupo_id => 107
OcuOcupaciones.create! :id => 376, :nombre => 'Operadores de máquinas de tratamiento de pieles y cueros', :codigo => '8155', :subgrupo_id => 107
OcuOcupaciones.create! :id => 377, :nombre => 'Operadores de máquinas para la fabricación de calzado y afines', :codigo => '8156', :subgrupo_id => 107
OcuOcupaciones.create! :id => 378, :nombre => 'Operadores de máquinas lavarropas', :codigo => '8157', :subgrupo_id => 107
OcuOcupaciones.create! :id => 379, :nombre => 'Operadores de máquinas para fabricar productos textiles y artículos de piel y cuero no clasificados bajo otros epígrafes', :codigo => '8159', :subgrupo_id => 107
OcuOcupaciones.create! :id => 380, :nombre => 'Operadores de máquinas para elaborar alimentos y productos afines', :codigo => '8160', :subgrupo_id => 108
OcuOcupaciones.create! :id => 381, :nombre => 'Operadores de instalaciones para la preparación de pasta para papel y papel', :codigo => '8171', :subgrupo_id => 109
OcuOcupaciones.create! :id => 382, :nombre => 'Operadores de instalaciones de procesamiento de la madera', :codigo => '8172', :subgrupo_id => 109
OcuOcupaciones.create! :id => 383, :nombre => 'Operadores de instalaciones de vidriería y cerámica', :codigo => '8181', :subgrupo_id => 110
OcuOcupaciones.create! :id => 384, :nombre => 'Operadores de máquinas de vapor y calderas', :codigo => '8182', :subgrupo_id => 110
OcuOcupaciones.create! :id => 385, :nombre => 'Operadores de máquinas de embalaje, embotellamiento y etiquetado ', :codigo => '8183', :subgrupo_id => 110
OcuOcupaciones.create! :id => 386, :nombre => 'Operadores de máquinas y de instalaciones fijas no clasificados bajo otros epígrafes', :codigo => '8189', :subgrupo_id => 110
OcuOcupaciones.create! :id => 387, :nombre => 'Ensambladores de maquinaria mecánica', :codigo => '8211', :subgrupo_id => 111
OcuOcupaciones.create! :id => 388, :nombre => 'Ensambladores de equipos eléctricos y electrónicos', :codigo => '8212', :subgrupo_id => 111
OcuOcupaciones.create! :id => 389, :nombre => 'Ensambladores no clasificados bajo otros epígrafes', :codigo => '8219', :subgrupo_id => 111
OcuOcupaciones.create! :id => 390, :nombre => 'Maquinistas de locomotoras', :codigo => '8311', :subgrupo_id => 112
OcuOcupaciones.create! :id => 391, :nombre => 'Guardafrenos, guardagujas y agentes de maniobras', :codigo => '8312', :subgrupo_id => 112
OcuOcupaciones.create! :id => 392, :nombre => 'Conductores de motocicletas', :codigo => '8321', :subgrupo_id => 113
OcuOcupaciones.create! :id => 393, :nombre => 'Conductores de automóviles, taxis y camionetas', :codigo => '8322', :subgrupo_id => 113
OcuOcupaciones.create! :id => 394, :nombre => 'Conductores de autobuses y tranvías', :codigo => '8331', :subgrupo_id => 114
OcuOcupaciones.create! :id => 395, :nombre => 'Conductores de camiones pesados', :codigo => '8332', :subgrupo_id => 114
OcuOcupaciones.create! :id => 396, :nombre => 'Operadores de maquinaria agrícola y forestal móvil', :codigo => '8341', :subgrupo_id => 115
OcuOcupaciones.create! :id => 397, :nombre => 'Operadores de máquinas de movimiento de tierras y afines', :codigo => '8342', :subgrupo_id => 115
OcuOcupaciones.create! :id => 398, :nombre => 'Operadores de grúas, aparatos elevadores y afines', :codigo => '8343', :subgrupo_id => 115
OcuOcupaciones.create! :id => 399, :nombre => 'Operadores de autoelevadoras', :codigo => '8344', :subgrupo_id => 115
OcuOcupaciones.create! :id => 400, :nombre => 'Marineros de cubierta y afines', :codigo => '8350', :subgrupo_id => 116
OcuOcupaciones.create! :id => 401, :nombre => 'Limpiadores y asistentes domésticos', :codigo => '9111', :subgrupo_id => 117
OcuOcupaciones.create! :id => 402, :nombre => 'Limpiadores y asistentes de oficinas, hoteles y otros establecimientos', :codigo => '9112', :subgrupo_id => 117
OcuOcupaciones.create! :id => 403, :nombre => 'Lavanderos y planchadores manuales', :codigo => '9121', :subgrupo_id => 118
OcuOcupaciones.create! :id => 404, :nombre => 'Lavadores de vehículos', :codigo => '9122', :subgrupo_id => 118
OcuOcupaciones.create! :id => 405, :nombre => 'Lavadores de ventanas', :codigo => '9123', :subgrupo_id => 118
OcuOcupaciones.create! :id => 406, :nombre => 'Otro personal de limpieza', :codigo => '9129', :subgrupo_id => 118
OcuOcupaciones.create! :id => 407, :nombre => 'Peones de explotaciones agrícolas', :codigo => '9211', :subgrupo_id => 119
OcuOcupaciones.create! :id => 408, :nombre => 'Peones de explotaciones ganaderas', :codigo => '9212', :subgrupo_id => 119
OcuOcupaciones.create! :id => 409, :nombre => 'Peones de explotaciones de cultivos mixtos y ganaderos', :codigo => '9213', :subgrupo_id => 119
OcuOcupaciones.create! :id => 410, :nombre => 'Peones de jardinería y horticultura', :codigo => '9214', :subgrupo_id => 119
OcuOcupaciones.create! :id => 411, :nombre => 'Peones forestales', :codigo => '9215', :subgrupo_id => 119
OcuOcupaciones.create! :id => 412, :nombre => 'Peones de pesca y acuicultura', :codigo => '9216', :subgrupo_id => 119
OcuOcupaciones.create! :id => 413, :nombre => 'Peones de minas y canteras', :codigo => '9311', :subgrupo_id => 120
OcuOcupaciones.create! :id => 414, :nombre => 'Peones de obras públicas y mantenimiento', :codigo => '9312', :subgrupo_id => 120
OcuOcupaciones.create! :id => 415, :nombre => 'Peones de la construcción de edificios', :codigo => '9313', :subgrupo_id => 120
OcuOcupaciones.create! :id => 416, :nombre => 'Empacadores manuales', :codigo => '9321', :subgrupo_id => 121
OcuOcupaciones.create! :id => 417, :nombre => 'Peones de la industria manufacturera no clasificados bajo otros epígrafes', :codigo => '9329', :subgrupo_id => 121
OcuOcupaciones.create! :id => 418, :nombre => 'Conductores de vehículos accionados a pedal o a brazo', :codigo => '9331', :subgrupo_id => 122
OcuOcupaciones.create! :id => 419, :nombre => 'Conductores de vehículos y máquinas de tracción animal', :codigo => '9332', :subgrupo_id => 122
OcuOcupaciones.create! :id => 420, :nombre => 'Peones de carga', :codigo => '9333', :subgrupo_id => 122
OcuOcupaciones.create! :id => 421, :nombre => 'Reponedores de estanterías', :codigo => '9334', :subgrupo_id => 122
OcuOcupaciones.create! :id => 422, :nombre => 'Cocineros de comidas rápidas', :codigo => '9411', :subgrupo_id => 123
OcuOcupaciones.create! :id => 423, :nombre => 'Ayudantes de cocina', :codigo => '9412', :subgrupo_id => 123
OcuOcupaciones.create! :id => 424, :nombre => 'Trabajadores ambulantes de servicios y afines', :codigo => '9510', :subgrupo_id => 124
OcuOcupaciones.create! :id => 425, :nombre => 'Vendedores ambulantes (excluyendo de comida)', :codigo => '9520', :subgrupo_id => 125
OcuOcupaciones.create! :id => 426, :nombre => 'Recolectores de basura y material reciclable', :codigo => '9611', :subgrupo_id => 126
OcuOcupaciones.create! :id => 427, :nombre => 'Clasificadores de desechos', :codigo => '9612', :subgrupo_id => 126
OcuOcupaciones.create! :id => 428, :nombre => 'Barrenderos y afines', :codigo => '9613', :subgrupo_id => 126
OcuOcupaciones.create! :id => 429, :nombre => 'Mensajeros, mandaderos, maleteros y repartidores', :codigo => '9621', :subgrupo_id => 127
OcuOcupaciones.create! :id => 430, :nombre => 'Personas que realizan trabajos varios', :codigo => '9622', :subgrupo_id => 127
OcuOcupaciones.create! :id => 431, :nombre => 'Recolectores de dinero en aparatos de venta automática y lectores de medidores', :codigo => '9623', :subgrupo_id => 127
OcuOcupaciones.create! :id => 432, :nombre => 'Acarreadores de agua y recolectores  de  leña', :codigo => '9624', :subgrupo_id => 127
OcuOcupaciones.create! :id => 433, :nombre => 'Ocupaciones elementales no clasificadas bajo otros epígrafes', :codigo => '9629', :subgrupo_id => 127
OcuOcupaciones.create! :id => 434, :nombre => 'Oficiales de las fuerzas armadas', :codigo => '0110', :subgrupo_id => 128
OcuOcupaciones.create! :id => 435, :nombre => 'Suboficiales de las fuerzas armadas', :codigo => '0210', :subgrupo_id => 129
OcuOcupaciones.create! :id => 436, :nombre => 'Otros miembros de las fuerzas armadas', :codigo => '0310', :subgrupo_id => 130




