using System;
using System.Linq;
using System.Web.Mvc;
using TesteSeniorSolution.Models;

namespace TesteSeniorSolution.Controllers
{
    public class ListUsuarioController : Controller
    {
        // GET: ListUsuario
        public ActionResult Index()
        {
            return View();
        }

        public JsonResult ListaUsuario(tb_usuario usuario)
        {
            try
            {
                if (usuario.cd_id_usuario != 0)
                {
                    using (var context = new TesteSeniorSolutionEntities())
                    {
                        var resposta = (from detalheUsu in context.tb_usuario_det
                                        join usu in context.tb_usuario on detalheUsu.cd_id_detalhe equals usu.cd_id_detalhe
                                        where usu.cd_id_usuario == usuario.cd_id_usuario
                                        select new
                                        {
                                            cd_id_usuario = usu.cd_id_usuario,
                                            nm_nome = usu.nm_nome,
                                            nm_sobrenome = usu.nm_sobrenome,
                                            nm_email = usu.nm_email,
                                            cd_id_detalhe = usu.cd_id_detalhe,
                                            nm_endereco = detalheUsu.nm_endereco,
                                            nm_telefone = detalheUsu.nm_telefone
                                        }).ToArray();

                        return Json(resposta, JsonRequestBehavior.AllowGet);
                    }
                }
                else
                {
                    using (var context = new TesteSeniorSolutionEntities())
                    {
                        var resposta = (from detalheUsu in context.tb_usuario_det
                                        join usu in context.tb_usuario on detalheUsu.cd_id_detalhe equals usu.cd_id_detalhe
                                        orderby usu.cd_id_usuario ascending
                                        select new
                                        {
                                            cd_id_usuario = usu.cd_id_usuario,
                                            nm_nome = usu.nm_nome,
                                            nm_sobrenome = usu.nm_sobrenome,
                                            nm_email = usu.nm_email,
                                            cd_id_detalhe = usu.cd_id_detalhe,
                                            nm_endereco = detalheUsu.nm_endereco,
                                            nm_telefone = detalheUsu.nm_telefone
                                        }).ToArray();
                        
                        return Json(resposta, JsonRequestBehavior.AllowGet);
                    }
                }
            }
            catch
            {
                return base.Json("ERRO", JsonRequestBehavior.AllowGet);
            }
        }

        public JsonResult AlteraUsuario(tb_usuario usuario, tb_usuario_det usuarioDet)
        {
            try
            {
                using (var context = new TesteSeniorSolutionEntities())
                {
                    tb_usuario usuarioBD = context.tb_usuario.First(u => u.cd_id_usuario == usuario.cd_id_usuario);
                    usuarioBD.nm_nome = usuario.nm_nome;
                    usuarioBD.nm_sobrenome = usuario.nm_sobrenome;
                    usuarioBD.nm_email = usuario.nm_email;

                    context.SaveChanges();

                    tb_usuario_det usuarioDetDb = context.tb_usuario_det.First(ud => ud.cd_id_detalhe == usuarioBD.cd_id_detalhe);
                    usuarioDetDb.nm_endereco = usuarioDet.nm_endereco;
                    usuarioDetDb.nm_telefone = usuarioDet.nm_telefone;

                    context.SaveChanges();

                    return base.Json("Sucesso", JsonRequestBehavior.AllowGet);
                }
            }
            catch (Exception ex)
            {
                return base.Json("ERRO", JsonRequestBehavior.AllowGet);
            }
        }

        public JsonResult ApagaUsuario(tb_usuario usuario, tb_usuario_det usuarioDet)
        {
            try
            {
                using (var context = new TesteSeniorSolutionEntities())
                {
                    tb_usuario usuarioBD = context.tb_usuario.First(u => u.cd_id_usuario == usuario.cd_id_usuario);
                    int cod_detalhe = usuarioBD.cd_id_detalhe;
                    context.tb_usuario.Remove(usuarioBD);

                    context.SaveChanges();

                    tb_usuario_det usuarioDetDb = context.tb_usuario_det.First(ud => ud.cd_id_detalhe == cod_detalhe);
                    context.tb_usuario_det.Remove(usuarioDetDb);

                    context.SaveChanges();

                    return base.Json("Sucesso", JsonRequestBehavior.AllowGet);
                }
            }
            catch
            {
                return base.Json("ERRO", JsonRequestBehavior.AllowGet);
            }
        }
    }
}