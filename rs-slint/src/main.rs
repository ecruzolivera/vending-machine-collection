use env_logger::Builder;
use log;

slint::include_modules!();

fn main() -> Result<(), slint::PlatformError> {
    Builder::new().filter_level(log::LevelFilter::max()).init();
    log::info!("starting ui");

    let ui = AppWindow::new()?;

    ui.global::<CategoryCardCallback>()
        .on_categorySelected(|category_id| {
            log::info!("selected category {}", category_id);
        });

    ui.global::<ItemCardCallback>().on_itemInc(|item_id| {
        log::info!("item incremented {}", item_id);
    });

    ui.global::<ItemCardCallback>().on_itemDec(|item_id| {
        log::info!("item decremented {}", item_id);
    });

    ui.run()
}
