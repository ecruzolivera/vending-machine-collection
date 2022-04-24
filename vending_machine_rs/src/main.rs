use gtk::prelude::{
    ButtonExt,
    Inhibit,
    LabelExt,
    OrientableExt,
    WidgetExt,
};
use gtk::Orientation::Vertical;

use relm::Widget;
use relm_derive::{Msg, widget};

pub struct Model {
    counter: i32,
}

#[derive(Msg)]
pub enum Msg {
    Decrement,
    Increment,
    Quit,
}

#[widget]
impl Widget for Win {

    fn model() -> Model {
        Model {
            counter: 0,
        }
    }

    view! {
        gtk::Window {
            gtk::Box {
                orientation: Vertical,
                gtk::Button {
                    clicked => Msg::Increment,
                    label: "+",
                },
                gtk::Label {
                    text: &self.model.counter.to_string(),
                },
                gtk::Button {
                    clicked => Msg::Decrement,
                    label: "-",
                },
            },
            delete_event(_, _) => (Msg::Quit, Inhibit(false)),
        }
    }
    
    fn update(&mut self, event: Msg) {
        match event {
            Msg::Decrement => self.model.counter -= 1,
            Msg::Increment => self.model.counter += 1,
            Msg::Quit => gtk::main_quit(),
        }
    }
}

fn main() {
    Win::run(()).unwrap();
}