import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_cached_pdfview/flutter_cached_pdfview.dart';

class Metodologias extends StatefulWidget {
  const Metodologias({super.key});

  @override
  _MetodologiasState createState() => _MetodologiasState();
}

class _MetodologiasState extends State<Metodologias> {
  final List<Section> _sections = [
    Section(
      header: 'MANUTENÇÃO DO LABORATÓRIO',
      items: ['CUIDADOS COM OS REAGENTES', 'LIMPEZA NO LABORATÓRIO'],
      isExpanded: false,
    ),
    Section(
      header: 'PROCEDIMENTOS DAS ANÁLISES FÍSICO-QUÍMICAS',
      items: [
        'DETERMINAÇÃO DE ALCALINIDADE TOTAL',
        'DETERMINAÇÃO DE CIANETO TOTAL E LIVRE',
        'DETERMINAÇÃO DE CIANETO TOTAL E LIVRE Adaptação LEA',
        'DETERMINAÇÃO DE CLORETOS',
        'DETERMINAÇÃO DE DUREZA',
        'DETERMINAÇÃO DE DQO Método Colorimétrico',
        'DETERMINAÇÃO DE DQO Método do Refluxo Aberto',
        'DETERMINAÇÃO DE DQO Método do Refluxo Fechado com Espectrofotômetro',
        'DETERMINAÇÃO DE DQO Método do Refluxo Fechado Titulométrico',
        'DETERMINAÇÃO DE DEMANDA BIOQUÍMICA DE OXIGÊNIO',
        'DETERMINAÇÃO DE OXIGÊNIO DISSOLVIDO',
        'RESÍDUOS',
        'SÓLIDOS TOTAIS EM AMOSTRAS DE LODO (GRAVIMETRIA)',
        'SÓLIDOS SUSPENSOS VOLÁTEIS EM LODOS (GRAVIMETRIA)',
        'DETERMINAÇÃO DE ÁCIDOS GRAXOS VOLÁTEIS (AGV)',
        'ÁCIDOS ORGÂNICOS VOLÁTEIS – AOV',
        'MICROSCOPIA ELETRÔNICA DE VARREDURA (MEV)',
        'DETERMINAÇÃO DE pH - LODO E ESGOTO',
        'DETERMINAÇÃO DE UMIDADE - LODO E ESGOTO',
        'ÓLEOS E GRAXAS – OG',
        'LIGNINA',
        'DETERMINAÇÃO DAS FRAÇÕES DE CLOROFILA E FEOFITINA DO FITOPLÂNCTON',
        'DETERMINAÇÃO DE CLOROFILA A Método Scor - UNESCO em Strickland & Parsons'
      ],
      isExpanded: false,
    ),
    Section(
      header: 'PROCEDIMENTOS DAS ANÁLISES DE NUTRIENTES',
      items: [
        'DETERMINAÇÃO DE Ca, Mg e K',
        'SÉRIE NITROGENADA',
        'NITROGÊNIO TOTAL (NTK) (NOrg + N-NH3 (ou NH+4)) - Método Nitrogênio Kjeldahl',
        'NITROGÊNIO AMONIACAL (N-NH3 (ou NH+4)): AMÔNIA TOTAL OU NH3 - Método do Indofenol',
        'DETERMINAÇÃO DE FÓSFORO TOTAL Standard Methods – 1985',
        'DETERMINAÇÃO DE CARBOIDRATOS',
        'DETERMINAÇÃO DE AMIDO EM MANIPUEIRA',
        'DETERMINAÇÃO DE METAIS'
      ],
      isExpanded: false,
    ),
    Section(
      header: 'PROCEDIMENTOS DAS ANÁLISES MICROBIOLÓGICAS',
      items: [
        'BACTÉRIAS HETEROTRÓFICAS',
        'COLIFORMES TOTAIS - Membrana filtrante',
        'COLIFORMES TOTAIS - Método dos tubos múltiplos',
        'COLIFORMES TERMOTOLERANTES - Método dos tubos múltiplos',
        'COLIFORMES FECAIS E. coli - Membrana Filtrante',
        'ATIVIDADE METANOGÊNICA ESPECÍFICA (AME)',
        'METODOLOGIA DE OVOS DE HELMINTOS',
        'ENUMERAÇÃO DOS OVOS DE HELMINTOS',
        'ANÁLISE DE ESPOROS DE BACTÉRIAS AERÓBIAS'
      ],
      isExpanded: false,
    ),
    Section(
      header: 'PREPARO DE MEIOS DE CULTURA',
      items: [
        'CALDO LACTOSE - CAT. M1003-500G',
        'CALDO BILE VERDE BRILHANTE 2% - CAT. M121-500G',
        'CALDO EC - CAT. M127-500G'
      ],
      isExpanded: false,
    ),
    Section(
      header: 'CALIBRAÇÃO DE EQUIPAMENTOS',
      items: ['CALIBRAÇÃO DO AQUACOLOR', 'REFERÊNCIAS BIBLIOGRÁFICAS'],
      isExpanded: false,
    ),
  ];
  List<Section> _filteredSections = [];

//=~=~=~==~=~=~=~==~=~=~=~==~=~=~=~==~=~==~=~=~=~==~=~=~=~==~=~=~=~=~=~==~=~=LINKS~=~==~=~=~=~~=~==~=~===~=~=~=~==~=~=~=~==~=~=~=~==~=~=~=~==~=~=

  final Map<String, String> itemUrls = {
    'CUIDADOS COM OS REAGENTES':
        'https://firebasestorage.googleapis.com/v0/b/fir-storage-79233.appspot.com/o/metodologias%2F1%20-%20MANUTEN%C3%87%C3%83O%20DO%20LABORAT%C3%93RIO%2FCUIDADOS%20COM%20OS%20REAGENTES.pdf?alt=media&token=e81dfb66-d411-497f-9f65-9170da1e9cfe',
    'LIMPEZA NO LABORATÓRIO':
        'https://firebasestorage.googleapis.com/v0/b/fir-storage-79233.appspot.com/o/metodologias%2F1%20-%20MANUTEN%C3%87%C3%83O%20DO%20LABORAT%C3%93RIO%2FLIMPEZA%20NO%20LABORAT%C3%93RIO.pdf?alt=media&token=7e2afdcf-4653-4cd7-b0d2-a1e7614db60c',
    'DETERMINAÇÃO DE ALCALINIDADE TOTAL':
        'https://firebasestorage.googleapis.com/v0/b/fir-storage-79233.appspot.com/o/metodologias%2F2%20-%20PROCEDIMENTOS%20DAS%20AN%C3%81LISES%20F%C3%8DSICO-QU%C3%8DMICAS%2FDETERMINA%C3%87%C3%83O%20DE%20ALCALINIDADE%20TOTAL.pdf?alt=media&token=fd8c116c-0c74-40f8-8bf6-4949f411ed90',
    'DETERMINAÇÃO DE CIANETO TOTAL E LIVRE':
        'https://firebasestorage.googleapis.com/v0/b/fir-storage-79233.appspot.com/o/metodologias%2F2%20-%20PROCEDIMENTOS%20DAS%20AN%C3%81LISES%20F%C3%8DSICO-QU%C3%8DMICAS%2FDETERMINA%C3%87%C3%83O%20DE%20CIANETO%20TOTAL%20E%20LIVRE.pdf?alt=media&token=28df736c-2f5d-4f63-8650-664dfccab850',
    'DETERMINAÇÃO DE CIANETO TOTAL E LIVRE Adaptação LEA':
        'https://firebasestorage.googleapis.com/v0/b/fir-storage-79233.appspot.com/o/metodologias%2F2%20-%20PROCEDIMENTOS%20DAS%20AN%C3%81LISES%20F%C3%8DSICO-QU%C3%8DMICAS%2FDETERMINA%C3%87%C3%83O%20DE%20CIANETO%20TOTAL%20E%20LIVRE%20Adapta%C3%A7%C3%A3o%20LEA.pdf?alt=media&token=ac826d06-7cd2-4fc5-b30a-6fa042fe50cd',
    'DETERMINAÇÃO DE CLORETOS':
        'https://firebasestorage.googleapis.com/v0/b/fir-storage-79233.appspot.com/o/metodologias%2F2%20-%20PROCEDIMENTOS%20DAS%20AN%C3%81LISES%20F%C3%8DSICO-QU%C3%8DMICAS%2FDETERMINA%C3%87%C3%83O%20DE%20CLORETOS.pdf?alt=media&token=f4d66f32-fb71-4bea-a289-c9605655e95a',
    'DETERMINAÇÃO DE DUREZA':
        'https://firebasestorage.googleapis.com/v0/b/fir-storage-79233.appspot.com/o/metodologias%2F2%20-%20PROCEDIMENTOS%20DAS%20AN%C3%81LISES%20F%C3%8DSICO-QU%C3%8DMICAS%2FDETERMINA%C3%87%C3%83O%20DE%20DUREZA.pdf?alt=media&token=054ca140-5359-4f1d-9240-34be489af909',
    'DETERMINAÇÃO DE DQO Método Colorimétrico':
        'https://firebasestorage.googleapis.com/v0/b/fir-storage-79233.appspot.com/o/metodologias%2F2%20-%20PROCEDIMENTOS%20DAS%20AN%C3%81LISES%20F%C3%8DSICO-QU%C3%8DMICAS%2FDETERMINA%C3%87%C3%83O%20DE%20DQO%20M%C3%A9todo%20Colorim%C3%A9trico.pdf?alt=media&token=1df48152-3543-4bc3-857a-64b9105c60c4',
    'DETERMINAÇÃO DE DQO Método do Refluxo Aberto':
        'https://firebasestorage.googleapis.com/v0/b/fir-storage-79233.appspot.com/o/metodologias%2F2%20-%20PROCEDIMENTOS%20DAS%20AN%C3%81LISES%20F%C3%8DSICO-QU%C3%8DMICAS%2FDETERMINA%C3%87%C3%83O%20DE%20DQO%20M%C3%A9todo%20do%20Refluxo%20Aberto.pdf?alt=media&token=5c9c901b-7dd2-4fe7-a5e1-f6f8d9410600',
    'DETERMINAÇÃO DE DQO Método do Refluxo Fechado com Espectrofotômetro':
        'https://firebasestorage.googleapis.com/v0/b/fir-storage-79233.appspot.com/o/metodologias%2F2%20-%20PROCEDIMENTOS%20DAS%20AN%C3%81LISES%20F%C3%8DSICO-QU%C3%8DMICAS%2FDETERMINA%C3%87%C3%83O%20DE%20DQO%20M%C3%A9todo%20do%20Refluxo%20Fechado%20com%20Espectrofot%C3%B4metro.pdf?alt=media&token=f690e30f-ff13-4fc2-9b3c-a9b2fdb298d7',
    'DETERMINAÇÃO DE DQO Método do Refluxo Fechado Titulométrico':
        'https://firebasestorage.googleapis.com/v0/b/fir-storage-79233.appspot.com/o/metodologias%2F2%20-%20PROCEDIMENTOS%20DAS%20AN%C3%81LISES%20F%C3%8DSICO-QU%C3%8DMICAS%2FDETERMINA%C3%87%C3%83O%20DE%20DQO%20M%C3%A9todo%20do%20Refluxo%20Fechado%20Titulom%C3%A9trico.pdf?alt=media&token=132a331f-ac31-4a64-85f7-46a6e44f3b37',
    'DETERMINAÇÃO DE DEMANDA BIOQUÍMICA DE OXIGÊNIO':
        'https://firebasestorage.googleapis.com/v0/b/fir-storage-79233.appspot.com/o/metodologias%2F2%20-%20PROCEDIMENTOS%20DAS%20AN%C3%81LISES%20F%C3%8DSICO-QU%C3%8DMICAS%2FDETERMINA%C3%87%C3%83O%20DE%20DEMANDA%20BIOQU%C3%8DMICA%20DE%20OXIG%C3%8ANIO.pdf?alt=media&token=4365cc7a-a1f5-467f-bfde-9ef1fc26bc99',
    'DETERMINAÇÃO DE OXIGÊNIO DISSOLVIDO':
        'https://firebasestorage.googleapis.com/v0/b/fir-storage-79233.appspot.com/o/metodologias%2F2%20-%20PROCEDIMENTOS%20DAS%20AN%C3%81LISES%20F%C3%8DSICO-QU%C3%8DMICAS%2FDETERMINA%C3%87%C3%83O%20DE%20OXIG%C3%8ANIO%20DISSOLVIDO.pdf?alt=media&token=14314789-c1dd-4e7c-81a8-0f914f317c62',
    'RESÍDUOS':
        'https://firebasestorage.googleapis.com/v0/b/fir-storage-79233.appspot.com/o/metodologias%2F2%20-%20PROCEDIMENTOS%20DAS%20AN%C3%81LISES%20F%C3%8DSICO-QU%C3%8DMICAS%2FRES%C3%8DDUOS.pdf?alt=media&token=7331fde8-738a-45d6-b772-adeab622e6f0',
    'SÓLIDOS TOTAIS EM AMOSTRAS DE LODO (GRAVIMETRIA)':
        'https://firebasestorage.googleapis.com/v0/b/fir-storage-79233.appspot.com/o/metodologias%2F2%20-%20PROCEDIMENTOS%20DAS%20AN%C3%81LISES%20F%C3%8DSICO-QU%C3%8DMICAS%2FS%C3%93LIDOS%20TOTAIS%20EM%20AMOSTRAS%20DE%20LODO%20(GRAVIMETRIA).pdf?alt=media&token=3b4c4b4f-76fd-497f-bca1-c455b99380bf',
    'SÓLIDOS SUSPENSOS VOLÁTEIS EM LODOS (GRAVIMETRIA)':
        'https://firebasestorage.googleapis.com/v0/b/fir-storage-79233.appspot.com/o/metodologias%2F2%20-%20PROCEDIMENTOS%20DAS%20AN%C3%81LISES%20F%C3%8DSICO-QU%C3%8DMICAS%2FS%C3%93LIDOS%20SUSPENSOS%20VOL%C3%81TEIS%20EM%20LODOS%20(GRAVIMETRIA).pdf?alt=media&token=382cd7e7-ca11-4bd5-93ec-534b78e3ec82',
    'DETERMINAÇÃO DE ÁCIDOS GRAXOS VOLÁTEIS (AGV)':
        'https://firebasestorage.googleapis.com/v0/b/fir-storage-79233.appspot.com/o/metodologias%2F2%20-%20PROCEDIMENTOS%20DAS%20AN%C3%81LISES%20F%C3%8DSICO-QU%C3%8DMICAS%2FDETERMINA%C3%87%C3%83O%20DE%20%C3%81CIDOS%20GRAXOS%20VOL%C3%81TEIS%20(AGV).pdf?alt=media&token=3df3324b-4ebf-4eff-9ed1-a0dbe1347f04',
    'ÁCIDOS ORGÂNICOS VOLÁTEIS – AOV':
        'https://firebasestorage.googleapis.com/v0/b/fir-storage-79233.appspot.com/o/metodologias%2F2%20-%20PROCEDIMENTOS%20DAS%20AN%C3%81LISES%20F%C3%8DSICO-QU%C3%8DMICAS%2F%C3%81CIDOS%20ORG%C3%82NICOS%20VOL%C3%81TEIS%20%E2%80%93%20AOV.pdf?alt=media&token=52debd20-c4ea-49da-b800-aad8df0d1dde',
    'MICROSCOPIA ELETRÔNICA DE VARREDURA (MEV)':
        'https://firebasestorage.googleapis.com/v0/b/fir-storage-79233.appspot.com/o/metodologias%2F2%20-%20PROCEDIMENTOS%20DAS%20AN%C3%81LISES%20F%C3%8DSICO-QU%C3%8DMICAS%2FMICROSCOPIA%20ELETR%C3%94NICA%20DE%20VARREDURA%20(MEV).pdf?alt=media&token=31829e59-24c2-4827-9330-e68ea33d8400',
    'DETERMINAÇÃO DE pH - LODO E ESGOTO':
        'https://firebasestorage.googleapis.com/v0/b/fir-storage-79233.appspot.com/o/metodologias%2F2%20-%20PROCEDIMENTOS%20DAS%20AN%C3%81LISES%20F%C3%8DSICO-QU%C3%8DMICAS%2FDETERMINA%C3%87%C3%83O%20DE%20pH%20-%20LODO%20E%20ESGOTO.pdf?alt=media&token=efe8b84a-0450-4d0d-b6f3-21dde331cc95',
    'DETERMINAÇÃO DE UMIDADE - LODO E ESGOTO':
        'https://firebasestorage.googleapis.com/v0/b/fir-storage-79233.appspot.com/o/metodologias%2F2%20-%20PROCEDIMENTOS%20DAS%20AN%C3%81LISES%20F%C3%8DSICO-QU%C3%8DMICAS%2FDETERMINA%C3%87%C3%83O%20DE%20UMIDADE%20-%20LODO%20E%20ESGOTO.pdf?alt=media&token=91b5b840-d8d6-4c43-a149-01612885bbd3',
    'ÓLEOS E GRAXAS – OG':
        'https://firebasestorage.googleapis.com/v0/b/fir-storage-79233.appspot.com/o/metodologias%2F2%20-%20PROCEDIMENTOS%20DAS%20AN%C3%81LISES%20F%C3%8DSICO-QU%C3%8DMICAS%2F%C3%93LEOS%20E%20GRAXAS%20%E2%80%93%20OG.pdf?alt=media&token=c02ab218-bf3a-44e2-92ea-b985994cfabc',
    'LIGNINA':
        'https://firebasestorage.googleapis.com/v0/b/fir-storage-79233.appspot.com/o/metodologias%2F2%20-%20PROCEDIMENTOS%20DAS%20AN%C3%81LISES%20F%C3%8DSICO-QU%C3%8DMICAS%2FLIGNINA.pdf?alt=media&token=2baf187e-feae-408b-91ad-f5a366767e58',
    'DETERMINAÇÃO DAS FRAÇÕES DE CLOROFILA E FEOFITINA DO FITOPLÂNCTON':
        'https://firebasestorage.googleapis.com/v0/b/fir-storage-79233.appspot.com/o/metodologias%2F2%20-%20PROCEDIMENTOS%20DAS%20AN%C3%81LISES%20F%C3%8DSICO-QU%C3%8DMICAS%2FDETERMINA%C3%87%C3%83O%20DAS%20FRA%C3%87%C3%95ES%20DE%20CLOROFILA%20E%20FEOFITINA%20DO%20FITOPL%C3%82NCTON.pdf?alt=media&token=030d653c-2744-4bf3-8fad-6a5aa6ad3ff4',
    'DETERMINAÇÃO DE CLOROFILA A Método Scor - UNESCO em Strickland & Parsons':
        'https://firebasestorage.googleapis.com/v0/b/fir-storage-79233.appspot.com/o/metodologias%2F2%20-%20PROCEDIMENTOS%20DAS%20AN%C3%81LISES%20F%C3%8DSICO-QU%C3%8DMICAS%2FDETERMINA%C3%87%C3%83O%20DE%20CLOROFILA%20A%20M%C3%A9todo%20Scor%20-%20UNESCO%20em%20Strickland%20%26%20Parsons.pdf?alt=media&token=eff84436-aa65-4eec-9a6d-0c23dd695847',
    'DETERMINAÇÃO DE Ca, Mg e K':
        'https://firebasestorage.googleapis.com/v0/b/fir-storage-79233.appspot.com/o/metodologias%2F3%20-%20PROCEDIMENTOS%20DAS%20AN%C3%81LISES%20DE%20NUTRIENTES%2FDETERMINA%C3%87%C3%83O%20DE%20Ca%20Mg%20e%20K.pdf?alt=media&token=b2f3edfe-0939-4756-a409-a614b66e0b31',
    'SÉRIE NITROGENADA':
        'https://firebasestorage.googleapis.com/v0/b/fir-storage-79233.appspot.com/o/metodologias%2F3%20-%20PROCEDIMENTOS%20DAS%20AN%C3%81LISES%20DE%20NUTRIENTES%2FS%C3%89RIE%20NITROGENADA.pdf?alt=media&token=d5537383-bb16-4eba-8257-8bbf1b9c7095',
    'NITROGÊNIO TOTAL (NTK) (NOrg + N-NH3 (ou NH+4)) - Método Nitrogênio Kjeldahl':
        'https://firebasestorage.googleapis.com/v0/b/fir-storage-79233.appspot.com/o/metodologias%2F3%20-%20PROCEDIMENTOS%20DAS%20AN%C3%81LISES%20DE%20NUTRIENTES%2FNITROG%C3%8ANIO%20TOTAL%20(NTK)%20(NOrg%20%2B%20N-NH3%20(ou%20NH%2B4))%20-%20M%C3%A9todo%20Nitrog%C3%AAnio%20Kjeldahl.pdf?alt=media&token=bc17b572-64b3-4130-a467-30878c863fa0',
    'NITROGÊNIO AMONIACAL (N-NH3 (ou NH+4)): AMÔNIA TOTAL OU NH3 - Método do Indofenol':
        'https://firebasestorage.googleapis.com/v0/b/fir-storage-79233.appspot.com/o/metodologias%2F3%20-%20PROCEDIMENTOS%20DAS%20AN%C3%81LISES%20DE%20NUTRIENTES%2FNITROG%C3%8ANIO%20AMONIACAL%20(N-NH3%20(ou%20NH%2B4))%20-%20M%C3%A9todo%20do%20Indofenol.pdf?alt=media&token=f3ce9871-7396-4d53-a4d4-e45a41ccb8b9',
    'DETERMINAÇÃO DE FÓSFORO TOTAL Standard Methods – 1985':
        'https://firebasestorage.googleapis.com/v0/b/fir-storage-79233.appspot.com/o/metodologias%2F3%20-%20PROCEDIMENTOS%20DAS%20AN%C3%81LISES%20DE%20NUTRIENTES%2FDETERMINA%C3%87%C3%83O%20DE%20F%C3%93SFORO%20TOTAL%20Standard%20Methods%20%E2%80%93%201985.pdf?alt=media&token=b16bf862-f773-4e15-be85-f3e7ac5d8499',
    'DETERMINAÇÃO DE CARBOIDRATOS':
        'https://firebasestorage.googleapis.com/v0/b/fir-storage-79233.appspot.com/o/metodologias%2F3%20-%20PROCEDIMENTOS%20DAS%20AN%C3%81LISES%20DE%20NUTRIENTES%2FDETERMINA%C3%87%C3%83O%20DE%20CARBOIDRATOS.pdf?alt=media&token=b3f7272b-d236-4ad3-bd8f-076fd5bf4fa7',
    'DETERMINAÇÃO DE AMIDO EM MANIPUEIRA':
        'https://firebasestorage.googleapis.com/v0/b/fir-storage-79233.appspot.com/o/metodologias%2F3%20-%20PROCEDIMENTOS%20DAS%20AN%C3%81LISES%20DE%20NUTRIENTES%2FDETERMINA%C3%87%C3%83O%20DE%20AMIDO%20EM%20MANIPUEIRA.pdf?alt=media&token=f71de540-d7be-4a77-839c-85969243ee6e',
    'DETERMINAÇÃO DE METAIS':
        'https://firebasestorage.googleapis.com/v0/b/fir-storage-79233.appspot.com/o/metodologias%2F3%20-%20PROCEDIMENTOS%20DAS%20AN%C3%81LISES%20DE%20NUTRIENTES%2FDETERMINA%C3%87%C3%83O%20DE%20METAIS.pdf?alt=media&token=3f93c2e5-cc49-4b96-ae44-554c12b6d4cc',
    'BACTÉRIAS HETEROTRÓFICAS':
        'https://firebasestorage.googleapis.com/v0/b/fir-storage-79233.appspot.com/o/metodologias%2F4%20-%20PROCEDIMENTOS%20DAS%20AN%C3%81LISES%20MICROBIOL%C3%93GICAS%2FBACT%C3%89RIAS%20HETEROTR%C3%93FICAS.pdf?alt=media&token=48df5da9-c170-4bbc-bff9-639070ac28eb',
    'COLIFORMES TOTAIS - Membrana filtrante':
        'https://firebasestorage.googleapis.com/v0/b/fir-storage-79233.appspot.com/o/metodologias%2F4%20-%20PROCEDIMENTOS%20DAS%20AN%C3%81LISES%20MICROBIOL%C3%93GICAS%2FCOLIFORMES%20TOTAIS%20-%20Membrana%20filtrante.pdf?alt=media&token=51b3bac3-b83d-4047-a82b-8158769d31f3',
    'COLIFORMES TOTAIS - Método dos tubos múltiplos':
        'https://firebasestorage.googleapis.com/v0/b/fir-storage-79233.appspot.com/o/metodologias%2F4%20-%20PROCEDIMENTOS%20DAS%20AN%C3%81LISES%20MICROBIOL%C3%93GICAS%2FCOLIFORMES%20TOTAIS%20-%20M%C3%A9todo%20dos%20tubos%20m%C3%BAltiplos.pdf?alt=media&token=dceff5b0-3d7f-4430-9340-a06b4c119b0a',
    'COLIFORMES TERMOTOLERANTES - Método dos tubos múltiplos':
        'https://firebasestorage.googleapis.com/v0/b/fir-storage-79233.appspot.com/o/metodologias%2F4%20-%20PROCEDIMENTOS%20DAS%20AN%C3%81LISES%20MICROBIOL%C3%93GICAS%2FCOLIFORMES%20TERMOTOLERANTES%20-M%C3%A9todo%20dos%20tubos%20m%C3%BAltiplos.pdf?alt=media&token=ebe6d57a-22dd-4089-a9e3-ad5a6746dee8',
    'COLIFORMES FECAIS E. coli - Membrana Filtrante':
        'https://firebasestorage.googleapis.com/v0/b/fir-storage-79233.appspot.com/o/metodologias%2F4%20-%20PROCEDIMENTOS%20DAS%20AN%C3%81LISES%20MICROBIOL%C3%93GICAS%2FCOLIFORMES%20FECAIS%20E.%20coli%20-%20Membrana%20Filtrante.pdf?alt=media&token=270786f5-63ee-428a-a3dd-a6114f32e29f',
    'ATIVIDADE METANOGÊNICA ESPECÍFICA (AME)':
        'https://firebasestorage.googleapis.com/v0/b/fir-storage-79233.appspot.com/o/metodologias%2F4%20-%20PROCEDIMENTOS%20DAS%20AN%C3%81LISES%20MICROBIOL%C3%93GICAS%2FATIVIDADE%20METANOG%C3%8ANICA%20ESPEC%C3%8DFICA%20(AME).pdf?alt=media&token=8f932835-d937-4892-a753-96b0457483f9',
    'METODOLOGIA DE OVOS DE HELMINTOS':
        'https://firebasestorage.googleapis.com/v0/b/fir-storage-79233.appspot.com/o/metodologias%2F4%20-%20PROCEDIMENTOS%20DAS%20AN%C3%81LISES%20MICROBIOL%C3%93GICAS%2FMETODOLOGIA%20DE%20OVOS%20DE%20HELMINTOS.pdf?alt=media&token=4b03164d-7e27-4f19-b056-0764efbbe011',
    'ENUMERAÇÃO DOS OVOS DE HELMINTOS':
        'https://firebasestorage.googleapis.com/v0/b/fir-storage-79233.appspot.com/o/metodologias%2F4%20-%20PROCEDIMENTOS%20DAS%20AN%C3%81LISES%20MICROBIOL%C3%93GICAS%2FENUMERA%C3%87%C3%83O%20DOS%20OVOS%20DE%20HELMINTOS.pdf?alt=media&token=5ca6e8e2-9a60-4113-861e-bdd58abc1924',
    'ANÁLISE DE ESPOROS DE BACTÉRIAS AERÓBIAS':
        'https://firebasestorage.googleapis.com/v0/b/fir-storage-79233.appspot.com/o/metodologias%2F4%20-%20PROCEDIMENTOS%20DAS%20AN%C3%81LISES%20MICROBIOL%C3%93GICAS%2FAN%C3%81LISE%20DE%20ESPOROS%20DE%20BACT%C3%89RIAS%20AER%C3%93BIAS.pdf?alt=media&token=827771aa-519b-4253-bac8-1712d3d93a13',
    'CALDO LACTOSE - CAT. M1003-500G':
        'https://firebasestorage.googleapis.com/v0/b/fir-storage-79233.appspot.com/o/metodologias%2F5%20-%20PREPARO%20DE%20MEIOS%20DE%20CULTURA%2FCALDO%20LACTOSE%20-%20CAT.%20M1003-500G.pdf?alt=media&token=5398d9d7-776c-4fa3-b72f-df9ca0b4be0c',
    'CALDO BILE VERDE BRILHANTE 2% - CAT. M121-500G':
        'https://firebasestorage.googleapis.com/v0/b/fir-storage-79233.appspot.com/o/metodologias%2F5%20-%20PREPARO%20DE%20MEIOS%20DE%20CULTURA%2FCALDO%20BILE%20VERDE%20BRILHANTE%202%25%20-%20CAT.%20M121-500G.pdf?alt=media&token=cf43570f-08d7-4cd2-b9e2-36d8608b09db',
    'CALDO EC - CAT. M127-500G':
        'https://firebasestorage.googleapis.com/v0/b/fir-storage-79233.appspot.com/o/metodologias%2F5%20-%20PREPARO%20DE%20MEIOS%20DE%20CULTURA%2FCALDO%20EC%20-%20CAT.%20M127-500G.pdf?alt=media&token=acc28d56-9677-4145-9ad9-c51edb2fa648',
    'CALIBRAÇÃO DO AQUACOLOR':
        'https://firebasestorage.googleapis.com/v0/b/fir-storage-79233.appspot.com/o/metodologias%2F6%20-%20CALIBRA%C3%87%C3%83O%20DE%20EQUIPAMENTOS%2FCALIBRA%C3%87%C3%83O%20DO%20AQUACOLOR.pdf?alt=media&token=c12af486-7ccc-4dcd-83f4-ee09987f8813',
    'REFERÊNCIAS BIBLIOGRÁFICAS':
        'https://firebasestorage.googleapis.com/v0/b/fir-storage-79233.appspot.com/o/metodologias%2F6%20-%20CALIBRA%C3%87%C3%83O%20DE%20EQUIPAMENTOS%2FREFER%C3%8ANCIAS%20BIBLIOGR%C3%81FICAS.pdf?alt=media&token=e6441f40-925c-4999-975d-4f04124a38a1',
  };

  @override
  void initState() {
    super.initState();
    _filteredSections = List.from(_sections);
  }

  void filterList(String query) {
    List<Section> filteredList = [];
    if (query.isNotEmpty) {
      filteredList.addAll(_sections.where((section) {
        bool sectionContainsQuery =
            section.header.toLowerCase().contains(query.toLowerCase());
        bool sectionContainsMatchingItems = section.items
            .any((item) => item.toLowerCase().contains(query.toLowerCase()));
        return sectionContainsQuery || sectionContainsMatchingItems;
      }));
    } else {
      filteredList = List.from(_sections);
    }
    setState(() {
      _filteredSections = filteredList;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF6F9FC),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              onChanged: filterList,
              decoration: const InputDecoration(
                labelText: 'Buscar',
                hintText: 'Insira a metodologia desejada',
                prefixIcon: Icon(Icons.search),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _filteredSections.length,
              itemBuilder: (BuildContext context, int index) {
                return Column(
                  children: [
                    Container(
                      color: Colors.grey[
                          300], // Adiciona cor de fundo para separar as seções
                      height: 0, // Define a altura da linha divisória
                      margin: const EdgeInsets.symmetric(
                          vertical: 10), // Adiciona espaçamento vertical
                    ),
                    ExpansionPanelList(
                      expansionCallback: (int sectionIndex, bool isExpanded) {
                        setState(() {
                          _filteredSections[index].isExpanded =
                              !_filteredSections[index].isExpanded;
                        });
                      },
                      children: [
                        ExpansionPanel(
                          headerBuilder:
                              (BuildContext context, bool isExpanded) {
                            return Container(
                              color: const Color.fromARGB(255, 81, 173, 249),
                              child: ListTile(
                                title: Text(
                                  _filteredSections[index].header,
                                  style: const TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            );
                          },
                          body: Container(
                            color: Colors.lightBlue[100],
                            child: ListView.builder(
                              shrinkWrap: true,
                              physics: const ClampingScrollPhysics(),
                              itemCount: _filteredSections[index].items.length,
                              itemBuilder:
                                  (BuildContext context, int itemIndex) {
                                return GestureDetector(
                                  onTap: () {
                                    if (itemUrls.containsKey(
                                        _filteredSections[index]
                                            .items[itemIndex])) {
                                      kIsWeb
                                          ? linkAppWeb(itemUrls[
                                              _filteredSections[index]
                                                  .items[itemIndex]]!)
                                          : Navigator.push(
                                              context,
                                              MaterialPageRoute<dynamic>(
                                                builder: (_) =>
                                                    PDFViewerCachedFromUrl(
                                                  url: itemUrls[
                                                      _filteredSections[index]
                                                          .items[itemIndex]]!,
                                                  name: _filteredSections[index]
                                                      .items[itemIndex],
                                                ),
                                              ),
                                            );
                                    }
                                  },
                                  child: Container(
                                    color: Colors.lightBlue[50],
                                    margin: const EdgeInsets.symmetric(
                                        vertical: 1, horizontal: 5),
                                    child: ListTile(
                                      title: Text(
                                        _filteredSections[index]
                                            .items[itemIndex],
                                        style: const TextStyle(
                                          color: Colors.black87,
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                          isExpanded: _filteredSections[index].isExpanded,
                        ),
                      ],
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class Section {
  Section({
    required this.header,
    required this.items,
    required this.isExpanded,
  });

  String header;
  List<String> items;
  bool isExpanded;
}

class PDFViewerCachedFromUrl extends StatelessWidget {
  const PDFViewerCachedFromUrl(
      {Key? key, required this.url, required this.name})
      : super(key: key);

  final String url;
  final String name;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(name),
      ),
      body: const PDF().cachedFromUrl(
        url,
        placeholder: (double progress) => Center(child: Text('$progress %')),
        errorWidget: (dynamic error) => Center(child: Text(error.toString())),
      ),
    );
  }
}

Future<void> linkAppWeb(String url) async {
  print("\n\link web");
  if (!(await launchUrl(Uri.parse(url),
      mode: LaunchMode.externalApplication))) {
    throw Exception('Could not launch url');
  }
}
