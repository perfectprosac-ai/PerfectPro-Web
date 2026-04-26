from pathlib import Path

from reportlab.lib import colors
from reportlab.lib.pagesizes import A4
from reportlab.lib.styles import ParagraphStyle, getSampleStyleSheet
from reportlab.lib.units import mm
from reportlab.platypus import Paragraph, SimpleDocTemplate, Spacer


def _build_styles():
    styles = getSampleStyleSheet()
    return {
        "title": ParagraphStyle(
            "TitleCustom",
            parent=styles["Title"],
            fontName="Helvetica-Bold",
            fontSize=18,
            leading=24,
            textColor=colors.HexColor("#0F4C5C"),
            spaceAfter=8,
        ),
        "h2": ParagraphStyle(
            "H2",
            parent=styles["Heading2"],
            fontName="Helvetica-Bold",
            fontSize=13,
            leading=18,
            textColor=colors.HexColor("#102A43"),
            spaceBefore=10,
            spaceAfter=4,
        ),
        "h3": ParagraphStyle(
            "H3",
            parent=styles["Heading3"],
            fontName="Helvetica-Bold",
            fontSize=11.5,
            leading=16,
            textColor=colors.HexColor("#243B53"),
            spaceBefore=8,
            spaceAfter=2,
        ),
        "body": ParagraphStyle(
            "Body",
            parent=styles["BodyText"],
            fontName="Helvetica",
            fontSize=10.5,
            leading=15,
            textColor=colors.HexColor("#1F2933"),
            spaceAfter=2,
        ),
        "bullet": ParagraphStyle(
            "Bullet",
            parent=styles["BodyText"],
            fontName="Helvetica",
            fontSize=10.5,
            leading=14,
            leftIndent=10,
            bulletIndent=0,
            textColor=colors.HexColor("#1F2933"),
            spaceAfter=1,
        ),
    }


def markdown_to_story(markdown_text: str):
    s = _build_styles()
    story = []
    for raw_line in markdown_text.splitlines():
        line = raw_line.strip()
        if not line:
            story.append(Spacer(1, 2.5 * mm))
            continue
        if line.startswith("# "):
            story.append(Paragraph(line[2:].strip(), s["title"]))
            continue
        if line.startswith("## "):
            story.append(Paragraph(line[3:].strip(), s["h2"]))
            continue
        if line.startswith("### "):
            story.append(Paragraph(line[4:].strip(), s["h3"]))
            continue
        if line.startswith("- [ ] "):
            story.append(Paragraph(line[6:].strip(), s["bullet"], bulletText="\u2610"))
            continue
        if line.startswith("- "):
            story.append(Paragraph(line[2:].strip(), s["bullet"], bulletText="\u2022"))
            continue
        if line[:3].isdigit() and line[1:3] == ". ":
            story.append(Paragraph(line, s["body"]))
            continue
        story.append(Paragraph(line, s["body"]))
    return story


def main():
    root = Path(__file__).resolve().parents[1]
    md_path = root / "docs" / "Parceiros_Tecnologicos_Guia.md"
    pdf_path = root / "docs" / "Parceiros_Tecnologicos_Guia.pdf"

    markdown_text = md_path.read_text(encoding="utf-8")
    story = markdown_to_story(markdown_text)

    doc = SimpleDocTemplate(
        str(pdf_path),
        pagesize=A4,
        leftMargin=20 * mm,
        rightMargin=20 * mm,
        topMargin=16 * mm,
        bottomMargin=16 * mm,
        title="Parceiros Tecnologicos - Guia de Execucao",
        author="PerfectPro",
        subject="Normatizacao de processos e checklist de alinhamento de producao",
    )
    doc.build(story)
    print(f"PDF gerado: {pdf_path}")


if __name__ == "__main__":
    main()
