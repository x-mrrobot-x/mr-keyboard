package com.mrkeyboard.app;

import java.util.HashMap;

/**
 * Mapa de erros comuns e abreviações de chat em pt-BR (v1.60). A chave é a forma digitada em
 * minúscula e sem acento (MrText.base); o valor é a sugestão. A sugestão entra como a melhor da
 * lista; com a autocorreção ligada ela só substitui a palavra se a digitada não for válida.
 * Lista curada à mão para este projeto.
 */
public final class MrFix {
    private MrFix() { }

    private static final String[] PAIRS = {
        // abreviações de chat
        "vc", "você", "vcs", "vocês", "tbm", "também", "tb", "também", "tmb", "também",
        "pq", "porque", "qdo", "quando", "qnd", "quando", "qndo", "quando", "hj", "hoje",
        "td", "tudo", "tds", "todos", "mto", "muito", "mt", "muito", "mta", "muita",
        "mtos", "muitos", "mtas", "muitas", "msm", "mesmo", "oq", "o que", "obg", "obrigado",
        "obgd", "obrigado", "obgda", "obrigada", "vlw", "valeu", "blz", "beleza", "cmg", "comigo",
        "ctg", "contigo", "nd", "nada", "ngm", "ninguém", "agr", "agora", "dps", "depois",
        "fds", "fim de semana", "bj", "beijo", "bjs", "beijos", "bjo", "beijo", "bjos", "beijos",
        "abs", "abraços", "pfv", "por favor", "pf", "por favor", "qq", "qualquer", "qlq", "qualquer",
        "sdds", "saudades", "vdd", "verdade", "msg", "mensagem", "msgs", "mensagens", "naum", "não",
        "neh", "né", "eh", "é", "aki", "aqui", "axo", "acho", "kd", "cadê", "cmo", "como",
        "tah", "tá", "qto", "quanto", "qta", "quanta", "qts", "quantos", "fzr", "fazer",
        "dnv", "de novo", "sla", "sei lá", "tmj", "tamo junto", "mds", "meu Deus", "sqn", "só que não",
        "pdc", "pode crer",
        // juntou palavras
        "concerteza", "com certeza", "comcerteza", "com certeza", "derrepente", "de repente",
        "derepente", "de repente", "porisso", "por isso", "apartir", "a partir", "denovo", "de novo",
        "oque", "o que", "daonde", "de onde", "encima", "em cima", "porfavor", "por favor",
        // fonética e grafia
        "enchergar", "enxergar", "excessao", "exceção", "excesao", "exceção", "exessao", "exceção",
        "exesao", "exceção", "previlegio", "privilégio", "previlegios", "privilégios",
        "previlegiado", "privilegiado", "mendingo", "mendigo", "mindingo", "mendigo",
        "sombrancelha", "sobrancelha", "sombrancelhas", "sobrancelhas", "beneficiente", "beneficente",
        "beneficiencia", "beneficência", "cidadoes", "cidadãos", "seje", "seja", "esteje", "esteja",
        "menas", "menos", "iorgute", "iogurte", "mortandela", "mortadela", "asteristico", "asterisco",
        "impecilho", "empecilho", "advinhar", "adivinhar", "advinha", "adivinha",
        "metereologia", "meteorologia", "bicabornato", "bicarbonato", "frustado", "frustrado",
        "frustada", "frustrada", "trousse", "trouxe", "salchicha", "salsicha", "cardeneta", "caderneta",
        "estrupo", "estupro", "prazeiroso", "prazeroso", "poblema", "problema", "pobrema", "problema",
        "enxer", "encher", "enxarcar", "encharcar", "fragancia", "fragrância", "ancioso", "ansioso",
        "anciosa", "ansiosa", "anciedade", "ansiedade", "atravez", "através", "ezemplo", "exemplo",
        "exelente", "excelente", "ezame", "exame", "nescessario", "necessário", "nescessaria", "necessária",
        "nescessidade", "necessidade", "reinvindicar", "reivindicar", "reinvindicacao", "reivindicação",
        "reinvidicar", "reivindicar", "cabelelero", "cabeleireiro", "cabeleleiro", "cabeleireiro",
        "cabelereiro", "cabeleireiro", "carangueijo", "caranguejo", "bandeija", "bandeja", "pexe", "peixe",
        "xuxu", "chuchu", "chicara", "xícara", "enxente", "enchente", "ecesso", "excesso", "exesso", "excesso",
        "exessivo", "excessivo", "tavez", "talvez", "gilo", "jiló", "beringela", "berinjela",
        "magestade", "majestade", "cosinha", "cozinha", "pesquiza", "pesquisa", "analizar", "analisar",
        "paralizar", "paralisar", "paralizacao", "paralisação", "atraz", "atrás", "mecher", "mexer",
        "enchugar", "enxugar", "chingar", "xingar", "enchame", "enxame", "puchar", "puxar",
        "fachina", "faxina", "brucha", "bruxa", "susseso", "sucesso", "suceso", "sucesso",
        "acessor", "assessor", "asessor", "assessor", "discucao", "discussão", "discusao", "discussão",
        "obcessao", "obsessão", "compreencao", "compreensão", "extencao", "extensão", "pretencao", "pretensão",
        "atensao", "atenção", "acensao", "ascensão", "decer", "descer", "naser", "nascer", "nacer", "nascer",
        "creser", "crescer", "crecer", "crescer", "picina", "piscina", "pissina", "piscina",
        "conciencia", "consciência", "esceto", "exceto", "expontaneo", "espontâneo", "extender", "estender",
        "explendido", "esplêndido", "beje", "bege", "garajem", "garagem", "exitar", "hesitar",
        "ogeriza", "ojeriza", "tijela", "tigela", "cangica", "canjica", "rabujento", "rabugento",
        "sargeta", "sarjeta", "gorgeta", "gorjeta", "geito", "jeito", "jente", "gente", "oje", "hoje",
        "omem", "homem", "aver", "haver", "ospital", "hospital", "quizer", "quiser", "fisesse", "fizesse",
        "cabecario", "cabeçalho", "buginganga", "bugiganga", "largatixa", "lagartixa", "largato", "lagarto",
        "superticao", "superstição", "adevogado", "advogado", "adivogado", "advogado", "ritimo", "ritmo",
        "adimirar", "admirar", "adiquirir", "adquirir", "guspe", "cuspe", "chicrete", "chiclete",
        "bicicreta", "bicicleta", "ingual", "igual", "cocha", "coxa", "enchaqueca", "enxaqueca",
        "cansaso", "cansaço", "cancado", "cansado", "passoca", "paçoca", "preguisa", "preguiça",
        "cabesa", "cabeça", "comesar", "começar", "conheso", "conheço",
    };

    private static HashMap<String, String> sMap;

    private static synchronized HashMap<String, String> map() {
        if (sMap == null) {
            HashMap<String, String> m = new HashMap<String, String>(PAIRS.length);
            for (int i = 0; i + 1 < PAIRS.length; i += 2) {
                m.put(PAIRS[i], PAIRS[i + 1]);
            }
            sMap = m;
        }
        return sMap;
    }

    /** Chave de busca: minúscula e sem acento. */
    static String key(CharSequence typed) {
        if (typed == null) return null;
        int n = typed.length();
        if (n == 0 || n > 24) return null;
        char[] k = new char[n];
        for (int i = 0; i < n; i++) k[i] = MrText.base(typed.charAt(i));
        return new String(k);
    }

    /** Sugestão para a palavra digitada, ou null. */
    public static String lookup(CharSequence typed) {
        String k = key(typed);
        if (k == null) return null;
        return map().get(k);
    }

    /** Quantidade de entradas (para testes). */
    static int size() {
        return map().size();
    }
}
