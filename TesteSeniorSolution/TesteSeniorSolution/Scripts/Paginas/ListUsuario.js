//Deve ter a URL da aplicação quando nao for localhost
var UrlAplicacao = ""

function LoadPage() {
    $("#m_id_usuario").val("");
    $("#m_nome_usuario").val("");
    $("#m_sobrenome_usuario").val("");
    $("#m_email_usuario").val("");
    $("#m_telefone_usuario").val("");
    $("#m_endereco_usuario").val("");
    $("#formConsulta").hide();
    $(".is-invalid").removeClass("is-invalid");
    $("#formConsulta").hide();
    $("#consulta").show();
    $('#grid').html('<thead class="thead-dark"></thead><tbody></tbody>');

    $.ajax({
        url: UrlAplicacao + '/ListUsuario/ListaUsuario',
        async: true,
        type: "GET",
        dataType: 'json',
        success: function (response) {
            if (response.length > 0) {
                $('#grid thead').html('<tr><th scope="col">ID Usuário</th><th scope="col">Nome</th><th scope="col">Sobrenome</th><th scope="col">E-mail</th><th scope="col">Telefone</th><th scope="col">Endereço</th><th scope="col"></th></tr>');
            }
            else {
                $('#grid').append('<tr><td class="text-danger">NENHUM USUÁRIO CADASTRADO.</td></tr>');
            }

            $(response).each(function (i, param) {
                $('#grid tbody').append(
                    '<tr>' +
                    '<th scope="row">' + param.cd_id_usuario + '</th>' +
                    '<td>' + param.nm_nome + '</td>' +
                    '<td>' + param.nm_sobrenome + '</td>' +
                    '<td>' + param.nm_email + '</td>' +
                    '<td>' + param.nm_telefone + '</td>' +
                    '<td>' + param.nm_endereco + '</td>' +
                    '<td><button id="btn_remover" type="button" class="btn btn-danger btn-sm" value="' + param.cd_id_usuario + '">Remover Usuário</button><button id="btn_editar" type="button" class="btn btn-success btn-sm" value="' + param.cd_id_usuario + '">Editar</button></td>' +
                    '</tr>'
                );
            });
        },
        error: function () {
            alert("Erro ao Consultar o Banco de Dados no carregamento da grid.\nTente novamente ou entre em contato com o suporte do sistema!");
        }
    });
}

function ValidaForm() {
    var retorno = true;
    if ($("#m_id_usuario").val() == "") {
        retorno = false;
        $("#m_id_usuario").addClass("is-invalid");
    }
    if ($("#m_nome_usuario").val() == "") {
        retorno = false;
        $("#m_nome_usuario").addClass("is-invalid");
    }
    if ($("#m_sobrenome_usuario").val() == "") {
        retorno = false;
        $("#m_sobrenome_usuario").addClass("is-invalid");
    }
    if ($("#m_email_usuario").val() == "") {
        retorno = false;
        $("#m_email_usuario").addClass("is-invalid");
    }
    if ($("#m_telefone_usuario").val() == "") {
        retorno = false;
        $("#m_telefone_usuario").addClass("is-invalid");
    }
    if ($("#m_endereco_usuario").val() == "") {
        retorno = false;
        $("#m_endereco_usuario").addClass("is-invalid");
    }
    return retorno;
}

function ComandosTela() {
    //Click do Editar
    $("#grid").delegate("#btn_editar", "click", function () {
        $("#m_id_usuario").val(this.value);

        $.ajax({
            url: UrlAplicacao + '/ListUsuario/ListaUsuario',
            async: true,
            type: "GET",
            dataType: 'json',
            data: {
                cd_id_usuario: this.value
            },
            success: function (response) {
                $(response).each(function (i, param) {
                    $("#m_nome_usuario").val(param.nm_nome);
                    $("#m_sobrenome_usuario").val(param.nm_sobrenome);
                    $("#m_email_usuario").val(param.nm_email);
                    $("#m_telefone_usuario").val(param.nm_telefone);
                    $("#m_endereco_usuario").val(param.nm_endereco);
                    $("#formConsulta").show();
                    $("#consulta").hide();
                });
            },
            error: function () {
                alert("Erro ao Consultar o Banco de Dados.\nTente novamente ou entre em contato com o suporte do sistema!");
            }
        });
    });

    //Click do Gravar
    $("#btn_gravar").click(function () {
        if (!ValidaForm()) {
            alert("Todos os campos devem ser preenchidos!")
            return false;
        }

        $.ajax({
            url: UrlAplicacao + '/ListUsuario/AlteraUsuario',
            async: true,
            type: "GET",
            dataType: 'json',
            data: {
                cd_id_usuario: $("#m_id_usuario").val(),
                nm_nome: $("#m_nome_usuario").val(),
                nm_sobrenome: $("#m_sobrenome_usuario").val(),
                nm_email: $("#m_email_usuario").val(),
                nm_telefone: $("#m_telefone_usuario").val(),
                nm_endereco: $("#m_endereco_usuario").val()
            },
            success: function (response) {
                if (response != "ERRO") {
                    alert("Alteração realizada com sucesso!");
                    LoadPage();
                }
                else
                    alert("Erro ao Consultar o Banco de Dados.\nTente novamente ou entre em contato com o suporte do sistema!");
            },
            error: function () {
                alert("Erro ao Consultar o Banco de Dados.\nTente novamente ou entre em contato com o suporte do sistema!");
            }
        });
    });

    //Click do Remover
    $("#grid").delegate("#btn_remover", "click", function () {
        $.ajax({
            url: UrlAplicacao + '/ListUsuario/ApagaUsuario',
            async: true,
            type: "GET",
            dataType: 'json',
            data: {
                cd_id_usuario: this.value
            },
            success: function (response) {
                if (response != "ERRO") {
                    alert("Exclusão realizada com sucesso!");
                    LoadPage();
                }
                else
                    alert("Erro ao Consultar o Banco de Dados.\nTente novamente ou entre em contato com o suporte do sistema!");
            },
            error: function () {
                alert("Erro ao Consultar o Banco de Dados.\nTente novamente ou entre em contato com o suporte do sistema!");
            }
        });
    });

    //Click do Cancelar
    $("#btn_cancelar").click(function () {
        LoadPage();
    });

    //Limpa validador
    $("input").change(function () {
        $(this).removeClass("is-invalid");
    });
}

$(function () {
    LoadPage();
    ComandosTela();
});