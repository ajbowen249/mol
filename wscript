top = '.'
out = 'build'

from dde.tools.dde_tasks import dde_options, configure_dde, build_dde_game

def options(ctx):
    dde_options(ctx)

def configure(ctx):
    configure_dde(ctx, ctx.path.find_node('dde'))

def build(bld):
    build_dde_game(
        bld,
        bld.path.find_node('src/acts/tests'),
        build_m100_co = False,
        build_hex = False,
        text_json = [
            bld.path.find_node('src/common/text.json'),
        ])

    build_dde_game(bld, bld.path.find_node('src/acts/bg31'), text_json = [
        bld.path.find_node('src/common/text.json'),
        bld.path.find_node('src/acts/bg31/text.json'),
    ])
